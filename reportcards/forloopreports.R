##for the files as .html, not utilizing the CSS properly
filenames = list.files(here("testscript"), pattern = ".Rmd")
file_count = length(filenames)
for (i in filenames) {
  rmarkdown::render(
    here("testscript/",i), envir = new.env(),clean = TRUE, output_dir = (here("outputs"))
  )
}

#test with pagedown
##(this puts the .html in the pagedown folder and pdf in the outputs folder)

filenames2 = list.files(here("pagedown"), pattern = ".Rmd")
file_count = length(filenames2)
for (x in filenames2) {
  pagedown::chrome_print(
    here("pagedown/",x), output = xfun::with_ext(here("outputs/",x), ext = ".pdf"))
}

##THIS IS THE CORRECT ONE TO USE
#try to get files in the correct places
filenames2 = list.files(here("pagedown"), pattern = ".Rmd")
file_count = length(filenames2)
for (x in filenames2) {
pagedown::chrome_print(rmarkdown::render(
  here("pagedown/",x), envir = new.env(),clean = TRUE, output_dir = (here("outputs"))))

}

#left to do: how to get it to move into the GH pages branch
