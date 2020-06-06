#==
Data load and processing
==#

using DataFrames, CSV
# using XLSX => this is for reading an Excel file

dataURL = "https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv"
dataFile = download(dataURL, "programming-languages.csv")

Ω = CSV.read(dataFile) |> DataFrame


# - - - - DataFrames operations
names(Ω) #gives a list with the names of the columns

# The Join Operator
foods = ["apple", "cucumber", "tomato", "banana"]
calories = [105, 47, 22, 105]
prices = [0.85, 1.6, 0.8, 0.6]
caloriesDataFrame = DataFrame(item = foods, calories = calories)
pricesDataFrame = DataFrame(item = foods, price = prices)
df = join(caloriesDataFrame, pricesDataFrame, on = :item)

#==
    Ω has two columns: year and language.
    * What is of a given language?
    * How many languages were created in a given year?
==#

function findRowsByColValue(df, column::String, value)
    filter(row -> row[Symbol(column)] == value, Ω)
end

# year by language is...
findRowsByColValue(Ω, "language", "Julia").:year

# languages by year are...
languagesRows = findRowsByColValue(Ω, "year", 2011)
println(nrow(languagesRows))
println(languagesRows.:language)
