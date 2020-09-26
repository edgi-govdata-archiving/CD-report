# CD-report
making .rmd for EDGI CD reports 

## Making CD Reports

1. Download the CD_76_Dirs.zip and extract it on your computer.  This file has all of the data from the AllPrograms Jupyter notebook for the 76 districts we will be making report cards for.  The data for each CD is in a separate directory.  There should be a png for the representative.  If not you will need to add one.
2. Download CD_76_maps_html.zip and extract it.  This file has HTML maps that will be used to create the png maps for the notebook.  (See the later instructions for how to do this.)
3. Download the Rmd template you will be using to construct the final report.

## Recommended working directory structure

```
CD-reports
    |
    |- CD_76_maps_png
    |    |
    |    |- AZ1_map.png
    |    |- CA22_map.png
    |    |- ...
    |
    |- CD_76_images
    |    |
    |    |- CA36_raul_ruiz.png
    |    |- CA44_nanette_barragan.png
    |    |- ...
    |    
    |- CD_76_Dirs
    |    |
    |    |- AZ1
    |    |    |
    |    |    |- active-facilities_All_pg3_AZ-1-091820.csv
    |    |    |- ...
    |    |
    |    |- CA6
    |    |    |
    |    |    |- active-facilities_All_pg3_CA-6-091820.csv
    |    |    |- ...    |    |
    |    |- ...
    |    
    |- reportcards
         |
         |- eew_template_VA4.Rmd
         |- eew_template_VA4.html
         |- eew_template_VA4.pdf
         |- ...
``` 

## Make a map PNG file of the right size

The HTML maps in CD_76_maps_html.zip are dynamic--they can be zoomed in or out to get the best view of the district.  We need to use a screen shot tool to snip out a static image, then use a photo or image editor to make our image the right size for the report cards.
We'll aim to make an image of the CD that is 490 pixels tall and 550 pixels wide.  We'll try to get them as close to those dimensions as possible, but being off by 1-5 pixels won't be noticable.
1. Open a map HTML file in a browser.  Zoom in and out to get the district to show as clearly as possible.
2. Use a screen snipping tool to snip a rectangle of approximately the right shape, but with a little extra on all sides.  Try to center the district in your rectangle.  Since we want width/height to end up 550/490, make your rectangle a little wider than it is tall, no matter what shape the district may be.
3. Open the screenshot image in your image editor.  I like the open source GNU Image Manipulation Program (GIMP). We'll use the image editor to size the image to the 550/490 preferred dimensions.
4. We need to figure out if we need to crop some off the top and bottom or off the sides.  
    a.  First, try setting the width to 550, let the image editor adjust the height to maintain proportions. If that makes the height adjust to less than 480, set the height to 480 and let it adjust the width to a number that will be larger than our preferred 550. Accept that, and we'll move on to cropping the sides.
    b.  If setting the width to 550 and letting the editor adjust the height results in a height greater than 490, accept that scaling and we'll move on to cropping the top and bottom.
5. We should now have an image in our editor that is correct for either height or width, and too large in the other dimension.  Hopefully there is enough border around our district in the scaled image that we can crop away enough from the edges that are too large to get to our desired shape.  
    a.  Make note of how much too large it is.  Depending on how you snipped from the original HTML you might want to take all of the excess of one side, or you might want to split it and take half off each side.
    b.  The image editor may have a pixel ruler on the sides that can help you see how much you are cropping.  Use a rectangle select tool to select the region you want to keep.  Remember that you already have one dimension just how you want it, so you should include all of that dimension.
5. When you have the image as close as you can get it to 550x490, export it as a PNG file with the name XXN_map.png, where XX is the state abbreviation, and N is the district number, like AZ1_map.png.
    a.  Save your XXN_map.png locally, perhaps in a a folder called CD_76_maps_png that is parallel to where you unpacked CD_76_Dirs.zip.  (We can't put them into the CD directory with the data, because all the data is stored in github in this one zip file, so we will each have our own copy of that data.)
    b.  Upload your XXN_map.png to the CD_76_maps_png directory in the CD-reports github repository, zipfile-csvs branch.
       

## Making a report card

You may need this link to find information for your representative if you don't already have it:  [GovTrack](https://govtrack.us/).
  
1. In the reportcards folder make a copy of the most recent eew_template.Rmd.  Name the new file eew_template_XXN.Rmd, where XX is the state abbreviation and N is the district number.
2. In RStudion use File->File Open to open the new .Rmd file.
3. Use Command-F (Mac) or Ctrl-F (Windows/Linux) to make these changes.  Use your own state and district in place of California's 36th district in these examples, and the state/district of the file you copied in place of Virginia's 4th.  **Run these replacements in this exact order.**
```
    a. Virginia's 4th --> California's 36th  (expect 2 replacements)
    b. VA 4 --> CA 36  (expect 9 replacements)
    c. _VA-4 --> _CA-36  (expect 26 replacements)
    d. VA4 --> CA36 (expect 23 replacements)
    
```    
4. Use the find function (but without any replacement) to look for this string:  'inspectionsper1000_All_pg4', then see what date stamp follows.  The date stamp for all of our data is 091820.  If the date you find is other than that (e.g. 090820), do another global find/replace:
``` 090820  -->  091820  (expect 6 replacements) ```
5. Use the find function to search for the string 'seat held by'.  Replace the representative's name with the one for your district.
6. Add the other information on the legislator.  Search for 'Legislator information' to locate the right section.
```
    a. If your directory is set up as above, the link to the image should look like:
        <a ><img src="../CD_76_images/CA36_raul_ruiz.png" style="float: left; width: 25%; margin-right: 5%" ></a>
    b. A few lines down, edit to get the correct committees and sub-committees.
```
7. Check image locations.  (Use the find function to look for 'png'.)  The logos appear twice, so check both of them.
``` There should be facilities2.png, eew_logo.png and edgi_logo.png images in the reportscard folder where you are running this from, 
    so the links should look like this:
      <a href="https://www.environmentalenforcementwatch.org/"><img src="eew_logo.png" style="float: left; width: 25%; margin-left: 20%" ></a>

      <a href="https://envirodatagov.org/"><img src="edgi_logo.png" style="float: right; width: 35%; margin-right: 20%" ></a>
    The link to the map file should look like this:
      <img src="../CD_76_maps_png/CA36_map2.png" alt="Snow" style="width:100%;">
    The legislator's image should be in the CD_76_images directory, so the link will be like:
      <a ><img src="../CD_76_images/CA36_raul_ruiz.png" style="float: left; width: 25%; margin-right: 5%" ></a>

```
8. In the Console area of RStudio, enter ```library(pagedown)``` and hit Enter.
9. In the Console area of RStudio, enter this command and hit Enter, changing it to your state and district:
``` pagedown::chrome_print( "eew_template_CA36.Rmd" ) ```
    
