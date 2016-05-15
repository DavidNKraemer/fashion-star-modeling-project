# Fashion Star Modeling Project

## Contributors

* David Kraemer
* William Rebelsky

# How to use this repository

The `src` directory contains all of the code used in producing this project.
This includes a `main.m` file, which solves the basic problem that is described
by the data in this file. We also have the following files:

| File name | Description |
|:----------|:------------|
| `problem_01.m` | Running this file gives the results for when we don't produce
velvet shirts | 
| `problem_02.m` | This is essentially the same as `main.m`, due to how the
prompt was written |
| `problem_03.m` | Scenario in which velvet can't be returned |
| `problem_04.m` | Scenario in which blazer costs are underestimated by $80 |
| `problem_05.m` | Scenario in which acetate supply increases by 10,000 |
| `problem_06a.m` | Scenario in which outlet stores sell at 60% profit |  
| `problem_06b.m` | Scenario in which outlet stores sell at 60% revenue |  

In MATLAB, the usage for any of these files is 

```Matlab
> problem_0#.m
```

which will print out the desired results. *Note*: The output is in short hand
variable names which are slightly annoying to read.


# Data

|Clothing Item        | Material Requirements | Price | Machine and Labor Costs |
|:--------------------|:----------------------|------:|------------------------:|
|Tailored wool slacks | 3 yards of wool       | $300.00 | $160.00 |
|                     |  2 yards of acetate for lining    | | |
|Cashmere sweater     | 1.5 yards of cashmere | $450.00 | $150.00 |
|Silk blouse          | 1.5 yards of silk     | $180.00 | $100.00 |
|Silk camisole        | 0.5 yards of silk     | $120.00 | $60.00 |
|Tailored skirt       | 2 yards of rayon      | $270.00 | $120.00 |
|                     | 1.5 yards of acetate for lining | | |
|Wool blazer          | 2.5 yards of wool     | $320.00 | $140.00 |
|                     | 1.5 yards of acetate for lining | | |

|Clothing Item | Material Requirements | Price | Machine and Labor Costs |
|:------------|:----------------------|------:|------------------------:|
|Velvet pants | 3 yards of velvet |  $350.00  | $175.00 |
|| 2 yards of acetate for lining | | |
|Cotton sweater |  1.5 yards of cotton |  $130.00 | $60.00 |
|Cotton miniskirt | 0.5 yards of cotton |  $75.00 | $40.00 |
|Velvet shirt |  1.5 yards of velvet |    $200.00   | $160.00 |
|Button-down blouse | 1.5 yards of rayon |$120.00| $90.00 |

| Material | Price per yard |
|:---------|---------------:|
| Wool | $9.00 |
| Acetate | $1.50 |
| Cashmere | $60.00 |
| Silk | $13.00 |
| Rayon | $2.25 |
| Velvet | $12.00 |
| Cotton | $2.50 |
