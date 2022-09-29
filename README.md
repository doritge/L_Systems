# L_Systems
Generating artwork using random generation of L-Systems rules

## General
L-System is a formal language that was invented by Aristid Lindenmayer to model the growth and evolution of plants. It was also found useful in generating geometries such as fractals, space-filling curves and tiles. In this project I explore artworks that results from generating random L-Systems rules

The code was implemented in R

## examples

**Mondrian-like**

<img src="/examples/LS11_random2_6998.png" width="400" height="400" />

**Wires**

<img src="/examples/LS16_random8_97.png" width="400" height="400" />


## Scripts
Script `produce_L.R` implements the function that receives L-Systems parameters, generates the action string and then generates the object itself. It then translates the object to the axis origin

Following are the action utils I implemented (P, D, are production / drawing engine commands respectively):

* **F, L, R** - (P) replace with relevant rule. (D) draw forward at a given length and direction. F is used usually. L, R are used when different rules apply to the drawing command
* **f** -  (P) replace with relevant rule. (D) go forward at a given length and direction but do not draw
* **+** - (D) add the predefined angle (turn left)
* **-** - (D) subtract the predefined angle (turn right)
* **[** - (D) push state for branching
* **]** - (D) pop state for end of branching
* **|** - (D) draw forward, no action replacement rule
* **X** - (D) mark a placeholder for external function
* **Any other letter** - (P) replace with relevant rule or ignore if no rule exists. (D) ignore

Script `produce_random_L.R` holds 3 functions. One that reads the log file, one the generates a random rule and one the produces an object from a seed number

The code in `test_rules.R` lets you generate automatically a batch of random objects that can further be curated to generate the artwork. 

Scripts `plot_utils.R` and `transform_utils` are general purpose utilities
