# Blemishine_Repository

# Haniwa Nose Geometry Analysis

This project implements geometric feature analysis of 3D models of Haniwa nose parts, including normal distribution analysis and model similarity comparison.

## Overview

The project consists of two main analysis modules:
1. Normal Distribution Analysis: Calculate and analyze surface normal variations
2. Model Similarity Analysis: Perform model registration and comparison using scaled ICP algorithm

## File Structure

### Data Preprocessing
- `transformData.m`: Convert .obj models to .mat format
- `triRename.m`: Standardize triangle mesh data filenames
- `matXRename.m`: Standardize vertex coordinate data filenames

### Normal Analysis
- `checkAdjacent1.m`: Calculate adjacent triangles for each face
- `checkAdjacentAll1.m`: Batch process adjacency relationships for all models
- `LastProcess5_1.m`: Calculate weighted average normal vectors for vertices
- `show6.m`: Visualize models and normal distributions

### Model Comparison
- `compareModel.m`: Main program for ICP registration and comparison
- `ssicp.m`: Implementation of scaled ICP algorithm

### Utility Functions
- `readObj.m`: Read .obj format 3D models
- `linspecer.m`: Generate color schemes for visualization

## Usage

1. Data Preparation:
   - Place Haniwa nose .obj model files in the data folder
   - Run transformData.m for format conversion

2. Normal Analysis:
   - Run processing programs 1-6 in sequence
   - View visualization results in show6.m

3. Model Comparison:
   - Run compareModel.m for model registration
   - Check generated comparison figures and error matrix

## Requirements

- MATLAB R2019b or higher
- Required Toolboxes:
  - Statistics and Machine Learning Toolbox (for kd-tree search)
  - Image Processing Toolbox

## Important Notes

- Comments in the code are in Chinese
- Model #30 should be skipped during processing
- ICP registration uses a scale factor of 3
- Supported model numbers: 001-125 (non-consecutive)
- Due to confidentiality agreements, the actual model files cannot be shared in this repository

## Output

The program generates:
1. Normal analysis results (weighted average normals for vertices)
2. Model registration results (comparison figures and RMSE error matrix)
3. Intermediate processing files (saved in respective subfolders)
