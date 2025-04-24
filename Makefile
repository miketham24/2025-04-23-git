# Define the output files
all: data/penguins_clean.rds data/train_data.rds output/confusion_matrix.rds figures/eda_boxplot.png t6-quarto.html

# Rule to load and clean data
data/penguins_clean.rds: R/01_load_data.R
	Rscript R/01_load_data.R

# Rule to perform exploratory data analysis and prepare the data for training
data/train_data.rds: R/02_eda.R data/penguins_clean.rds
	Rscript R/02_eda.R

# Rule to train the model
models/penguin_fit.rds: R/03_train.R data/train_data.rds
	Rscript R/03_train.R

# Rule to evaluate the model and generate confusion matrix
output/confusion_matrix.rds: R/04_evaluate.R models/penguin_fit.rds
	Rscript R/04_evaluate.R

# Rule to generate the EDA plot
figures/eda_boxplot.png: R/02_eda.R data/penguins_clean.rds
	Rscript R/02_eda.R

# Rule to render the Quarto document and generate the HTML output
t6-quarto.html: t6-quarto.qmd
	quarto render t6-quarto.qmd

# Clean up intermediate files
clean:
	rm -f data/penguins_clean.rds data/train_data.rds models/penguin_fit.rds output/confusion_matrix.rds figures/eda_boxplot.png t6-quarto.html
