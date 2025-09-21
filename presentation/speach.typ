Good morning, everyone! Today, I will be performing the defense of Bachelor's Final Project titled "Evaluating performance and energy impact of programming languages".

This will be the structure of my presentation:
- An *introduction* to the Project
- Then I will explain which languages I chose to perform this experiment and the reasons behind my choices.
- After that, I will explain the previous work done in this field as well as the methodology I followed to perform the experiments.
- Then, I will show you the results I obtained and the analysis I made of them.
- Finally, I will conclude with the main takeaways of this project.

= Introduction
When starting a project, one of the first decisions a developer has to make is which programming language to use. This decision can have a significant impact on various aspects of the project, including performance and energy consumption.

When having to make a decision, developers often rely on their personal preferences or the popularity of a language. However, these choices may not always lead to the best outcomes in terms of performance and energy efficiency.

Thus, it is crucial to have empirical data that can guide developers in making informed decisions about which programming language to use for their projects.


= Languages

== Language strengths
Choosing a programming language can be a complex decision influenced by various factors. How come this Python,C++, Rust Go and ADA code snippets produce the same output, but are so different in terms of syntax and structure?

There are many differences in how these languages work. Under the hood, Python is an interpreted language, which means that it is executed line by line by an interpreter. This leads to slower execution times compared to compiled languages like C++, Rust, or Go, which are compiled before execution, resulting in faster performance.

There are multiple interpreters for Python, such as CPython, which is the reference implementation (the default one), or PyPy, which uses a Just-In-Time (JIT) compiler to improve performance by compiling frequently executed code paths into machine code at runtime.

On the other hand, C++ is a statically typed, compiled language but it also has multiple compilers, such as GCC and Clang, which can produce different performance characteristics based on their optimization strategies.

Go is another compiled language, but it only has one main compiler, which is the one provided by the Go project itself, designed by Google.

= Previous works

However, the benchmarks used in this project are often criticized for not being
representative of real-world applications. For example, many of the benchmarks
are algorithmic in nature, such as sorting algorithms or numerical computations,
which may not reflect the performance characteristics of more complex
applications.




= Conslusions

== GPU usage
If GPUs were used for the benchmarks, we could expect significant improvements in performance, especially for tasks that can be parallelized. GPUs are designed to handle multiple threads simultaneously, making them ideal for workloads like image processing, machine learning, and scientific simulations.

However, not all programming languages and frameworks are optimized for GPU execution. Languages like CUDA C++ and OpenCL are specifically designed for GPU programming, while others may require additional libraries or frameworks to take advantage of GPU acceleration.
