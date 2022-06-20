# Data-pro Project

## Introduction

This repo contains a dataset about some medical doctors and health providers. The objective of this project is to write a python program to:

1. translate the name titles from French to English, using Google Translate API,
2. to calculate the duration those entities have been active in their services

In the dataset (data.csv file):

- id is the id of and entity
- name is the name of the corresponding entity
- validated_date and effective_date are the dates when the entity has been approved and started providing service, accordingly
- end_date is the data when an entity ends its service.

## Requirements

- python 3.x. Checked the installed version : `python --version` 
- pandas
- numpy
- google Translate API
- input is the data.csv file or similar files with the same format, output is a CSV file defined by an input parameter.

## Howto env setup and Run
1. Download the project : `git clone https://github.com/post-cyberlabs/data-pro.git`
2. Go to working directory : `cd ~\data-pro`
3. To install all dependencies : `pip install -r .\requirements.txt`

**Notes :**
To run the project user need to enter three argument in console. 
Example Command : `python .\experiment.py \datasetSourcePath .\outputFilePath`

4. Run the project : `python .\experiment.py .\data.csv .\OutputDataset.csv`

=====Enjoy the program====

