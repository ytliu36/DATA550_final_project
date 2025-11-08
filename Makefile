Report/DATA550_final_Yutong.html: Report/DATA550_final_Yutong.Rmd Source/03_render_report.R Output/Table_1.rds Output/Figure_1.rds
	Rscript Source/03_render_report.R

# Create Table 1
Output/Table_1.rds: Source/01_table1.R Data/alzheimers_disease_data.csv
	Rscript Source/01_table1.R

# Create Figure1
Output/Figure_1.rds: Source/02_figure1.R Data/alzheimers_disease_data.csv
	Rscript Source/02_figure1.R

.PHONY: clean
clean:
	rm -f Output/*.rds && rm -f Report/DATA550_final_Yutong.html

.PHONY: install
install: renv.lock .Rprofile Source/00_restore_packages.R
	Rscript Source/00_restore_packages.R
	