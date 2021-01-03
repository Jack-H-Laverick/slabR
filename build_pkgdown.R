## Build pkgdown site

# Run to build the website
pkgdown::build_site()




# Run to place the hex sticker in the right places
usethis::use_logo("./frames/1.640.png")
pkgdown::build_favicons(pkg = ".", overwrite = T)
