#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <sstream>
#include <algorithm>
using namespace std;

// separate_cumulative.cpp
// Reads an ASCII P3 PPM image and writes cumulative-row PPMs:
// frame_cum_1.ppm ... frame_cum_H.ppm where frame_cum_k contains the
// first k rows (height = k). This program focuses on P3 only.

static void fail(const string &msg){
    cerr << msg << "\n";
    exit(1);
}

int main(int argc, char** argv){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    string input_file = (argc>1) ? argv[1] : "output.ppm";
    string output_dir  = (argc>2) ? argv[2] : "output_img_cumulative";

    ifstream in(input_file);
    if(!in) fail("Failed to open input file: " + input_file);

    // read magic
    string magic;
    if(!(in >> magic)) fail("Failed to read PPM magic");
    if(magic != "P3") fail("This program supports only ASCII P3 PPM (found: " + magic + ")");

    // helper: read next non-comment token(s)
    auto read_next_token = [&](string &tok)->bool{
        while(true){
            if(!(in >> tok)) return false;
            if(tok.size()>0 && tok[0]=='#'){
                // skip rest of the line
                string rest;
                getline(in, rest);
                continue;
            }
            return true;
        }
    };

    string tok;
    if(!read_next_token(tok)) fail("Failed to read width");
    int width = stoi(tok);
    if(!read_next_token(tok)) fail("Failed to read height");
    int height = stoi(tok);
    if(!read_next_token(tok)) fail("Failed to read maxval");
    int maxval = stoi(tok);

    // prepare output dir
    if(system((string("mkdir -p ")+output_dir).c_str()) != 0){
        // non-fatal on some systems; continue
    }

    // We'll read pixel tokens row-by-row and keep an in-memory buffer of rows.
    // Each row is a string containing space-separated tokens for that row.
    vector<string> rows;
    rows.reserve(height);

    // Read width*height*3 integer tokens
    const size_t tokens_per_row = static_cast<size_t>(width) * 3;
    vector<string> tokenBuf;
    tokenBuf.reserve(tokens_per_row);

    string t;
    size_t collected = 0;
    while(true){
        if(!read_next_token(t)) break;
        tokenBuf.push_back(t);
        if(tokenBuf.size() == tokens_per_row){
            // build row string
            string rowline;
            rowline.reserve(tokens_per_row*4);
            for(size_t i=0;i<tokenBuf.size();++i){
                rowline += tokenBuf[i];
                if(i+1<tokenBuf.size()) rowline.push_back(' ');
            }
            rowline.push_back('\n');
            rows.push_back(move(rowline));
            tokenBuf.clear();
            collected++;
            if(collected == (size_t)height) break;
        }
    }

    if(rows.size() != (size_t)height){
        cerr << "Warning: parsed rows=" << rows.size() << " expected=" << height << "\n";
    }

    // Write cumulative files. We'll build a string for headers and then append rows progressively.
    string headerBase = magic + "\n" + to_string(width) + " ";

    // To avoid reopening and rewriting common prefix many times, we create each file separately
    // but we write rows by streaming to ofstream. This is straightforward and efficient.
    for(int k=1;k<= (int)rows.size(); ++k){
        string outpath = output_dir + "/frame_cum_" + to_string(k) + ".ppm";
        ofstream out(outpath, ios::binary);
        if(!out){ cerr << "Failed to open " << outpath << " for writing\n"; continue; }
        out << headerBase << k << "\n" << maxval << "\n";
        // write rows 0..k-1
        for(int r=0;r<k && r < (int)rows.size(); ++r){
            out << rows[r];
        }
        out.close();
    }

    cerr << "Wrote " << rows.size() << " cumulative files to " << output_dir << "\n";
    return 0;
}
