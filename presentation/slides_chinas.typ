#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: codly-init.with()

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
    neutral-darkest: rgb("#0c2b5c"), // General colour of the bars,
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
  #text(size: 1.1em)[TFG Defense]
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
    #codly(languages: codly-languages)
    ```python
    def main():
        print("Hello, world!")
    ```

    #pause
    #codly(languages: codly-languages)
    ```go
    package main
    import "fmt"
    func main() {
        fmt.Println("Hello, world!")
    }
    ```
  ],
  [
    #pause
    #codly(languages: codly-languages)
    ```cxx
    #include <iostream>
    int main() {
        std::cout << "Hello, world!" << std::endl;
        return 0;
    }
    ```

    #pause
    #codly(languages: codly-languages)
    ```rust
    pub fn main() {
        println!("Hello, world!");
    }
    ```
  ],
)

== Characteristics of language
Talk about the fact python is interpreted, PyPy uses a JIT, and that C++ and Go
are compiled.

= Languages

== Language strengths comparison: TIOBE Index @tiobe-index

#set text(size: 1em)
#set align(left)

- #emph[*C++*], Compiled, manual memory management, ~9.2%, Systems, games,
  HPC#footnote[High Performance Computing], embedded, performance-critical
  software.
#pause
- #emph[*Go*], Compiled, statically linked, ~2%, Microservices, networking,
  tooling, cloud infrastructure.
#pause
- #emph[*Python*], ~35%, interpreted, used for Web, Data Science, AI/ML,
  scripting, automation.
#pause
- #emph[*PyPy*], JIT#footnote[Just-In-Time] for Python — runtime compilation,
  ~3%, Long-running Python apps, performance-sensitive Python code.

== Why not this other language?

Add here pictures of rust, ADA, JavaScript, Metal and CUDA and talk smth



= Previous works

== Simple matrix multiplication example, with toy programs

#slide[
  #set text(size: 1.0em)
  #let times = (
    ("Python", 1.8111),
    ("Go", 0.9111),
    ("C++", 0.45111),
    ("PyPy", 0.5111),
  )
  #let max_tupple = times.fold(times.first(), (a, b) => if a.at(1) > b.at(1) {
    a
  } else { b })
  #let max = max_tupple.at(1)
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
      #box(
        width: t * horiz-scale,
        height: bar-height,
        fill: blue.lighten(25%),
        stroke: none,
      )[]
      #v(0.25em)
      #set text(size: .9em)
      #t s
    ] #h(1.2cm)
  ]

]

= Benchmark Design

== Program declaration
a

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





#focus-slide[
  Thanks!
]


= References

== References

#bibliography(title: none, "references.bib")


#show: appendix

// = Appendix

// == Appendix

// Please pay attention to the current slide number.

== this
