## What is Flukebook? 
Flukebook is an online platform designed for the documentation and organization of marine mammal interactions and associated data.

## What is a Bulk Import?
A rapid method to input your encounters and related information into Wildbook/flukebook.org by utilizing your images, along with a .xslx file.

## What is the purpose of this code?
This R code enables us to read and extract metadata from photos (e.g photos of whales for foto ID) using the 'exifr' package, and generates a compatible .xlsx file for bulk import in Flukebook.

## Some considerations:
- The photo metadata must include at least the GPS location (which is automatically embedded in drone images), the date, the creator's name, and the country. This information can be directly included using image processing software like Lightroom.
- Your spreadsheet should contain a maximum of 200 encounters.
- Avoid using special characters in your image file names or spreadsheet name. Special characters are anything other than letters of the English alphabet, numbers 0-9, spaces, or periods. Uploading these might lead to compatibility issues.
- Ensure uniqueness for all your file names.
