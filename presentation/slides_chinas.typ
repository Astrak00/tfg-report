#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: codly-init.with()
#codly(languages: codly-languages)

#let show_qr = true

// simple, metropolis, dewdrop, university, aqua, stargazer
#import themes.stargazer: *

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  navigation: "",
  config-info(
    title: [Evaluating performance and energy impact of programming languages],
    subtitle: [],
    author: [Eduardo Alarcón Navarro],
    date: datetime.today(),
    institution: [Universidad Carlos III de Madrid\ Tutor: Jose Daniel García
      Sánchez],
  ),
  config-colors(
    primary: rgb("#04364A"), // Top right second bar
    secondary: rgb("#176B87"),
    tertiary: rgb("#448C95"),
    neutral: rgb("#303030"),
    neutral-darkest: rgb("#0d2b5a"), // General colour of the bars,
    accent: rgb("#FF4081"), // Accent color for highlights,
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))


#let title-slide(image-path, title, author, tutor) = slide[
  #grid(
    columns: (1fr, 2fr),
    gutter: 1cm,
    [
      #image(image-path, width: 100%)
    ],
    [
      #text(size: 1.5em, weight: "bold")[#title]
    ],
  )

  #line(length: 100%, stroke: 1pt + blue)

  #set align(center)
  #text(size: 1.1em)[TFG Defense:]
  #text(style: "italic")[Grado en Ingeniería Informática] \
  #text(style: "italic")[Universidad Carlos III de Madrid]

  #linebreak()

  #author \
  Tutor: #tutor
]

#let double-result-slide(image1, image2) = slide[
  #grid(columns: (1fr, 1fr))[
    #set align(center)
    #image(image1, height: auto)
  ][
    #set align(center)
    #image(image2, height: auto)
  ]
]


#title-slide(
  "img/ray_traced_balls.png",
  [Evaluating performance and energy impact of programming languages],
  [Eduardo Alarcón Navarro],
  [Jose Daniel García Sánchez],
)

// Now when you use it:

#outline-slide()

= Introduction

== Motivation
This is my motivation to discuss the performance and energy impact of
programming languages.

== The problem with choosing a language

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #pause
    ```python
    print("Hello, world!")
    ```
    #pause
    ```cxx
    #include <iostream>
    int main() {
      std::cout << "Hello, world!\n";
      return 0;
    }
    ```

    #pause
    ```rust
    pub fn main() {
      println!("Hello, world!");
    }
    ```
  ],
  [
    #pause
    ```go
    package main
    import "fmt"
    func main() {
      fmt.Println("Hello, world!")
    }
    ```

    #pause
    ```ADA
    with Ada.Text_IO; use Ada.Text_IO;
    procedure Hello is
    begin
      Put_Line("Hello, world!");
    end Hello;
    ```
  ],
)


= Languages

== Language strengths comparison: TIOBE Index @tiobe-index


== Language strengths comparison: TIOBE Index — C++
// Slide 1: C++
#slide[
  #set text(size: 1em)
  #set align(left)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1cm,
    [
      #image("img/cpp_logo.png", width: 7em)
    ],
    [

      #image("img/win11.png", width: 11em)

      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 6em,
        [
          #image("img/macos_logo.png", width: 5em)
        ],
        [
          #image("img/tux.png", width: 5em)
        ],
      )
    ],
    [
      - #emph[*C++*], Compiled, manual memory management, ~9.2%, Systems, games,
        HPC#footnote[High Performance Computing], embedded, performance-critical
        software.
    ],
  )
]

// Slide 2: Go
== Language strengths comparison: TIOBE Index — Go
#slide[
  #set text(size: 1em)
  #set align(left)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1cm,
    [
      #image("img/go_logo.png", width: 10em)
    ],
    [
      #image("img/go_example.png", width: 10em)
    ],
    [
      - #emph[*Go*], Compiled, statically linked, ~2%, Microservices,
        networking, tooling, cloud infrastructure.
    ],
  )
]

// Slide 3: Python
== Language strengths comparison: TIOBE Index — Python

#slide[
  #set text(size: 1em)
  #set align(left)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1cm,
    [
      #image("img/python_logo.png", width: 10em)
    ],
    [
      #image("img/python_example.png", width: 12em)
    ],
    [
      - #emph[*Python*], ~35%, interpreted, used for Web, Data Science, AI/ML,
        scripting, automation.
    ],
  )
]


== Why not this other language?

#grid(
  columns: (1.1fr, 1fr, 1fr, 1.2fr, 1fr),
  gutter: 1.5em,
  [
    #set text(size: 0.9em)
    #image("img/rust_logo.png", width: 6em)
    #pause
    Simmilar to C++
  ],
  [
    #pause
    #image("img/ada_logo.png", width: 6em)
    #set text(size: 0.9em)
    #pause
    Not as popular as others
  ],
  [
    #pause
    #image("img/js_logo.png", width: 6em)
    #set text(size: 0.9em)
    #pause
    Not used for compute intensive tasks
  ],
  [
    #pause
    #image("img/metal_logo.png", width: 6em)
    #set text(size: 0.9em)
    #pause
    GPU programming language & proprietary
  ],
  [
    #pause
    #image("img/cuda_logo.png", width: 6em)
    #set text(size: 0.9em)
    #pause
    GPU programming language & C/C++ extension
  ],
)



= Previous works

== Example: Computer Language Benchmarks Game
The Computer Language Benchmarks Game is a well-known project that compares the
performance of various programming languages using a set of benchmarks.

#image("img/benchmarks_game.png", width: 30em)



= Benchmark Design


#image("img/ray_traced_balls.png", width: 30em)

== Ray Tracing

#image("img/ray_tracer_explaination.png", width: 20em)

= Results

== Interactive viewer
#box[
  #set text(size: 1em, weight: "bold")

  #grid(
    columns: (auto, 1fr),
    gutter: 1cm,
    [
      #image("img/charts.png", width: 25em)
    ],
    [
      Benchmark outcomes across programming languages: \
      #h(0.4em)
      #link("https://charts-tfg.astrak.es/")[View interactive charts at\
        #underline[charts-tfg.astrak.es]]

      #set align(right)
      #if show_qr [
        #v(0.4em)
        #image("img/qr-charts.png", width: 4.6em)
      ]
    ],
  )

]

#for platform in ("Server", "Desktop", "Laptop", "RPi") {
  [== #platform results]
  double-result-slide(
    "img/graphs/log-" + str(lower(platform)) + "-energy.png",
    "img/graphs/log-" + str(lower(platform)) + "-time.png",
  )
}

= Conclusions

== Summary of Findings

This is otra cosa and includes a gif, but does not have movement when exported
to pdf


== What would happen if GPUs were used? - Metal
#grid(
  columns: (1fr, 1.3fr),
  gutter: 4cm,
  [
    #image("img/m4_gpu.png", width: 17em)
  ],
  [
    Execution time: 1.14 s
    #linebreak()
    Energy consumption: 6.362 J / 0.001767 Wh
  ],
)



#focus-slide[
  Thanks!
]


// = References

// == References

// #bibliography(title: none, "references.bib")


// #show: appendix

// = Appendix

// == Appendix

// Please pay attention to the current slide number.
