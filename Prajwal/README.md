# Student Satellite Project - Indian Institude of Technology, Bombay

## Star Tracker-based Attitude Determination System (STADS)

### Author - KT Prajwal Prathiksh

This repository contains the code for the **Star Matching** - block of STADS, based on the algorithm - *Brightness Independent 4-Star Matching Algorithm*, developed by the Tsinghua University.

This repository is structured in the following way:
1. *..\Catalogues* - Folder contains all the required star catalogues
1. *sm_main_4_str_mtch_algo.m* - Main code to run the star-matching algorithm
1. *sm_gnrt_CSPA.m* - Function that generates the Candidate Star Pair Array for a given angular distance 
1. *sm_gnrt_K_VEC.m* - Generates the K-Vector for a given vector
1. *sm_preprocessing.m* - Generates the K-Vector from the Preprocessed Catalogue
1. *sm_true_values.m* - Contains the true values *(test-cases)*