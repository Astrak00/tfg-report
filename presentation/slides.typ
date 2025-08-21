// Slides
#import "@preview/polylux:0.4.0": *
// For the code blocks
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *



#show: codly-init.with()

#show link: set text(blue)
#set text(font: "Andika", size: 20pt)
#show raw: set text(font: "Fantasque Sans Mono")
#show math.equation: set text(font: "Lete Sans Math")

#let month_year = "September 2025"

#let my-stroke = stroke(
  thickness: 2pt,
  paint: blue.lighten(25%),
  cap: "round",
)

#set page(
  paper: "presentation-16-9",
  margin: 2cm,
  footer: [
    #set text(size: .6em)
    #set align(horizon)

    Eduardo Alarcón Navarro, #month_year #h(1fr) #toolbox.slide-number / #toolbox.last-slide-number
  ],
  header: box(stroke: (bottom: my-stroke), inset: 8pt)[
    #set text(size: .6em)
    #set align(horizon)
    #h(1fr)
    Evaluating performance and energy impact of programming languages | #toolbox.current-section
  ],
)

#show heading: set block(below: 2em)

#let new-section-slide(title) = slide[
  #set page(footer: none, header: none)
  #set align(horizon)
  #set text(size: 1.5em)
  #strong(title)
  #line(stroke: my-stroke, length: 60%)
  #toolbox.register-section(title)
]

#slide[
  #set page(footer: none, header: none)
  #set align(horizon)
  #text(size: 1.57em, weight: "bold")[
    #toolbox.side-by-side(columns: (auto, 1fr))[
      #image("/img/ray_traced_balls.png", height: 3em)
    ][
      Evaluating performance and energy impact of programming languages
    ]
  ]

  #line(stroke: my-stroke, length: 100%)
  #set align(center)

  TFG Defense \
  _Grado en Ingeniería Informática_ \
  _Universidad Carlos III de Madrid_

  Eduardo Alarcón Navarro \
  Tutor: Jose Daniel García Sánchez
]

#slide[
  = Outline
  #toolbox.all-sections((sections, current) => enum(tight: false, ..sections))
]

#new-section-slide("Introduction")

#slide[
  = Motivation

  // Add a graph with the programs being written and energy used in the world
]

#slide[
  = The problem with choosing a language

  // Add a slide with some syntax examples of different languages
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    // #set text(size: .9em)

    #codly(languages: codly-languages)
    ```python
    def main():
        print("Hello, world!")
    ```

    #show: later
    #codly(languages: codly-languages)
    ```go
    package main
    import "fmt"
    func main() {
        fmt.Println("Hello, world!")
    }
    ```
  ][
    #show: later
    #codly(languages: codly-languages)
    ```cxx
    #include <iostream>
    int main() {
        std::cout << "Hello, world!" << std::endl;
        return 0;
    }
    ```
    #show: later
    #codly(languages: codly-languages)
    ```rust
    pub fn main() {
        println!("Hello, world!");
    }
    ```
  ]
]

#slide[
  = Characteristics of language
  Talk about the fact python is interpreted, PyPy uses a JIT, and that C++ and Go are compiled.
]

#slide[
  = Runtime comparison matrix multiplication

  #set text(size: 1.05em)

  #let times = (
    ("Python", 1.8),
    ("Go", 0.9),
    ("C++", 0.45),
    ("PyPy", 0.5),
  )

  #let max = 1.8
  #let width-scale = 12cm / max

  #for (name, t) in times [
    *#name* #sym.arrow.r #t seconds \
  ]

  #set text(size: 1em)
  #let bar-height = 1.2em
  #let horiz-scale = 3.2cm / max

  #set align(center)
  #for (name, t) in times [
    #box[
      #set text(size: .95em, weight: "bold")
      #name
      #v(0.35em)
      #box(width: t * horiz-scale, height: bar-height, fill: blue.lighten(25%), stroke: none)[]
      #v(0.25em)
      #set text(size: .9em)
      #t s
    ] #h(1.2cm)
  ]
]


#new-section-slide("Previous work in the area")

#new-section-slide("Languages")

#slide[
  = C++
  #set text(size: 1.05em)
  #set align(left)

  // Image of C++ logo
  // #image("/img/cpp-logo.png", height: 3em)
]

#slide[
  = Go
  #set text(size: 1.05em)
  #set align(left)

  // Image of gopher
  // #image("/img/gopher.png", height: 3em)
]

#slide[
  = Python
  #set text(size: 1.05em)
  #set align(left)

  Python is a high-level, *interpreted* language known for its simplicity and readability. \
  It is widely used in various domains, including web development, data analysis, scientific computing and Artificial Intelligence.

  #v(0.5fr)

  // #image("/img/python-logo.png", height: 3em)
]

#slide[
  = PyPy
  #set text(size: 1.05em)
  #set align(left)

  Compilation Just in Time of python code. \

  It aims to improve the performance of Python programs by translating Python code into machine code at runtime.

  // #image("/img/pypy-logo.png", height: 3em)
]

#slide[
  = Language strengths comparison: TIOBE Index @tiobe-index
  #set text(size: 1em)
  #set align(left)

  #table(
    columns: (1fr, 2fr, 0.7fr, 3fr),
    align: (left, left, right, left),

    table.header[*Language*][*Execution model*][*Use (%) *][*Typical uses*],
  )

  #item-by-item(start: 1)[
    - #table(
        columns: (1fr, 2fr, 0.7fr, 3fr),
        align: (left, left, right, left),
        [Python], [Interpreted (bytecode), many implementations], [~35%], [Web, Data Science, AI/ML, scripting, automation],
      )

    - #table(
        columns: (1fr, 2fr, 0.7fr, 3fr),
        align: (left, left, right, left),
        [PyPy],
        [JIT#footnote[Just-In-Time] for Python — runtime compilation],
        [~3%],
        [Long-running Python apps, performance-sensitive Python code],
      )

    - #table(
        columns: (1fr, 2fr, 0.7fr, 3fr),
        align: (left, left, right, left),
        [Go], [Compiled, statically linked], [~2%], [Microservices, networking, tooling, cloud infrastructure],
      )

    - #table(
        columns: (1fr, 2fr, 0.7fr, 3fr),
        align: (left, left, right, left),
        [C++],
        [Compiled, manual memory management],
        [~9.2%],
        [Systems, games, HPC#footnote[High Performance Computing], embedded, performance-critical software],
      )
  ]
]


#new-section-slide("Benchmark Design")

#new-section-slide("Results")

#new-section-slide("Conclusions")

#slide[
  This is otra cosa and includes a gif, but does not have movement when exported to pdf

  #image("/img/cat-space.gif", height: auto)
]

#slide[
  #bibliography(title: none, "references.bib")

]
