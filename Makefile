# PART 1 - CSV Test
# Download test dataset.
data/test.csv:
	mkdir -p data
	curl -o $@ https://s3.amazonaws.com/data-code-test/test.csv

# Download state supplementary dataset.
data/state_abbreviations.csv:
	curl -o $@ https://s3.amazonaws.com/data-code-test/state_abbreviations.csv

# Read in test and supplementary data, output cleansed dataset.
data/solution.csv: data/test.csv data/state_abbreviations.csv clean_data.py
	python clean_data.py data/test.csv data/state_abbreviations.csv --output $@


# PART 2 - Web Scrape
# Scraper website at URL, and output data in JSON format.
URL=http://data-interview.enigmalabs.org/companies/
data/solution.json: scrape_edgar.py
	python scrape_edgar.py $(URL) --output $@


# Run both tests.
.PHONY = all_tests  # Tells make to expect no output for this task.
all_tests: data/solution.csv data/solution.json
