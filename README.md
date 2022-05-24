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
aqs_code <- 99
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

Now, we write the meta data header using `add_meta_data` function. 
We'll write the file in `home` folder (`~/`). 
The `add_meta_data` required the `aqs_meta` input which is a vector with key
value pairs with the air quality metadata.
We'll also use some information from our session and from `qualR` datasets to
complete the metadata like this:

```R
pin_meta <- c(
    "Station_id" = "BR01",
    "Station_country" = "Brazil",
    "Station_Local_id" = aqs_code,
    "Station_city" = "São Paulo",
    "Station_name" = cetesb_aqs$name[cetesb_aqs$code == aqs_code],
    "Station_timezoen" = Sys.timezone(),
    "Station_lon" = cetesb_aqs$lon[cetesb_aqs$code == aqs_code],
    "Station_lat" = cetesb_aqs$lat[cetesb_aqs$code == aqs_code],
    "Timeshift_from_utc" = as.POSIXlt(Sys.time())$zone
)
```

```R
# Writing meta data
add_meta_data(pin_o3, "o3", pin_meta,  date_format = "%Y-%m-%d %H:%M", 
              date = "date", csv_path = "~/")
```

Which create the file `O3_BR01_2021_2021.csv` (`POL_Station_id_start-year_end_year.csv`).

```
Station_id:BR01;
Station_country:Brazil;
Station_Local_id:99;
Station_city:Sao Paulo;
Station_name:Pinheiros;
Station_timezone:America/Sao_Paulo;
Station_lon:-46.7020165084763;
Station_lat:-23.5614598947311;
Timeshift_from_UTC:-03;
"Time; value";O3
"01/01/2021 00:00";NA
"01/01/2021 01:00";28
"01/01/2021 02:00";24
"01/01/2021 03:00";18
"01/01/2021 04:00";13
"01/01/2021 05:00";20
"01/01/2021 06:00";31
"01/01/2021 07:00";25
"01/01/2021 08:00";27
"01/01/2021 09:00";28

```
## Template for metadata:

Here is a template to "fill in the blanks":

```
aqs_meta <- c(
  "Station_id" = "",
  "Station_country" = "",
  "Station_Local_id" = "",
  "Station_name" = "",
  "Station_city" = "",
  "Station_timezone" = "",
  "Station_lon" = "",
  "Station_lat" = "",
  "Station_alt" = "",
  "Station_type" = "",
  "Time_reporting" = "",
  "Station_type_of_area" = "",
  "Station_category" = "",
  "Timeshift_from_UTC" = "",
  "Station_climatic_zone" = "",
  "Station_htap_region" = "",
  "Station_reported_alt" = "",
  "Station_dominant_landcover" = "",
  "Contributor" = "",
  "Contributor_shortname" = "",
  "Contributor_country" = "",
  "Dataset_PI" = "",
  "Dataset_PI_email" = "",
  "Sampling_type" = "",
  "Measurement_method" = "",
  "Instrument_manufacturer" = "",
  "Instrument_model" = "",
  "Original_units" = "",
  "Calibration" = "",
)
```
