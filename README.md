# TOPmetadata
A package to easily add air quality station meta data.

## Installation

First you need to install `devtools`:
```R
install.packages("devtools")
```

Then, you can install the package by:
```R
devtools::install_github("quishqa/TOPmetadata")
```

## An example using qualR

In this example we download ozone data from pinheiros using `qualR` package.
Then, we'll write the meta data to this dataset.

```R
library(qualR)
library(TOPmetadata)

pol_code <- "o3"
aqs_code <- "Pinheiros"
start_date <- "01/01/2021"
end_date <- "31/01/2021"

# Downloading data
pin_o3 <- cetesb_retrieve_param(Sys.getenv("QUALAR_USER"),
                                Sys.getenv("QUALAR_PASS"),
                                pol_code,
                                aqs_code,
                                start_date,
                                end_date)
```

Which produce this data:

```
> head(pin_o3)
date o3       aqs
1 2021-01-01 00:00:00 NA Pinheiros
2 2021-01-01 01:00:00 28 Pinheiros
3 2021-01-01 02:00:00 24 Pinheiros
4 2021-01-01 03:00:00 18 Pinheiros
5 2021-01-01 04:00:00 13 Pinheiros
6 2021-01-01 05:00:00 20 Pinheiros
```

Now, we write the meta data header using `add_met_data` function. 
We'll write the file in `home` folder (`~/`)

```R
# Writing meta data
add_meta_data(pin_o3, pol = pol_code, date_format = "%Y-%m-%d %H:%M", 
              date = "date", id = aqs_code, csv_path = "~/")
```

Which create the file `O3_Pinheiros_2021_2021.csv` (`POL_aqs_start-year_end_year.csv`).
```
Station_id:Pinheiros;
Station_timezone:America/Sao_Paulo;
Timeshift_from_UTC:-03;
"Time; value"O3
"01/01/2021 00:00";NA
"01/01/2021 01:00";28
"01/01/2021 02:00";24
"01/01/2021 03:00";18
"01/01/2021 04:00";13
"01/01/2021 05:00";20

```

