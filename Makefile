# REPORT-ASSOCIATED RULES
Reports/DATA550_final_Yutong.html: Reports/DATA550_final_Yutong.Rmd Source/03_render_report.R Output/Table_1.rds Output/Figure_1.rds
	Rscript Source/03_render_report.R

# Create Table 1
Output/Table_1.rds: Source/01_table1.R Data/alzheimers_disease_data.csv
	Rscript Source/01_table1.R

# Create Figure1
Output/Figure_1.rds: Source/02_figure1.R Data/alzheimers_disease_data.csv
	Rscript Source/02_figure1.R

.PHONY: clean
clean:
	rm -f Output/*.rds && rm -f Reports/DATA550_final_Yutong.html

.PHONY: install
install: renv.lock .Rprofile Source/00_restore_packages.R
	Rscript Source/00_restore_packages.R

# DOCKER-ASSOCIATED RULES
PROJECTFILES = Reports/DATA550_final_Yutong.Rmd Data/alzheimers_disease_data.csv Source/03_render_report.R Source/02_figure1.R Source/01_table1.R Makefile
RENVFILES = renv.lock .Rprofile Source/00_restore_packages.R renv/activate.R renv renv/settings.json renv

# rule to build image
project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t project_image .
# rule to build the report automatically
## Use make project_image
# Mac/Linux target
.PHONY: run_report
run_report:
	mkdir -p report
	docker run -v "$$(pwd)/report":/project/report project_image
# Windows target
.PHONY: run_report_win
run_report_win:
	mkdir -p report
	docker run -v /"$$(pwd)/report":/project/report project_image
## Use DockerHub image
# Mac/Linux target
.PHONY: run_report_hub
run_report_hub:
	mkdir -p report
	docker run -v "$$(pwd)/report":/project/report ytliu36/final_project_image:latest
# Windows target
.PHONY: run_report_win_hub
run_report_win_hub:
	mkdir -p report
	docker run -v /"$$(pwd)/report":/project/report ytliu36/final_project_image:latest
	