let cities = [];
let comparedCities = [];

fetch("/api/cities") // Sends HTTP request to Flask
    // fetch returns a promise to deliver the results
    .then(response => response.json()) // Flask reads JSON and parses it into JS
    // .then also returns a promise
    .then(data => { // takes parsed JSON and stores it into cities
        cities = data; // parameter name
        console.log(cities);
    });

// --- CITY OVERVIEW ---
const cityName = document.getElementById("city-name"); // Gets city name
const cityText = document.getElementById("city-text"); // Gets city description

// --- BUTTONS ---// in compare_cities OVERVIEW; allows clicking through city descriptions
const cityCounter = document.getElementById("city-counter");
let currentCity = 1; // let allows you to change the value

// --- NEXT DESCRIPTION BUTTON: connected to compare ---
const nextButton = document.getElementById("next-city");
if(nextButton){
    nextButton.addEventListener("click", function() {
        if (comparedCities.length === 0) return;

        if (currentCity >= comparedCities.length) {
            currentCity = 1;
        } else {
            currentCity++;
        }

        cityName.textContent = comparedCities[currentCity - 1].city_name;
        cityText.textContent = comparedCities[currentCity - 1].description;
        cityCounter.textContent = `City ${currentCity} of ${comparedCities.length}`;
    });
}

// --- PREVIOUS DESCRIPTION BUTTON ---
const prevButton = document.getElementById("prev-city");
if (prevButton){
    prevButton.addEventListener("click", function() {
        if (comparedCities.length === 0) return;

        if (currentCity <= 1) {
            currentCity = comparedCities.length;
        } else {
            currentCity--;
        }

        cityName.textContent = comparedCities[currentCity - 1].city_name;
        cityText.textContent = comparedCities[currentCity - 1].description;
        cityCounter.textContent = `City ${currentCity} of ${comparedCities.length}`;
    });
}



console.log(cityName)

// --- DISPLAYING STATISTICS IN TABLE ---
// To add a new cell, place the corresponding SQL attribute name in the IF statement
const populationCell = document.getElementById("city-population");

if (populationCell) {
    fetch("/api/cities")
        .then(response => response.json())
        .then(cities => {
            const louisville = cities.find(city => city.city_name === "Louisville");
            const medianIncome = document.getElementById("median-income");
            const povertyRate = document.getElementById("poverty-rate")

            if (louisville) {
                populationCell.textContent =
                    Number(louisville.population).toLocaleString("en-US"); // formats number into a string
            }

            medianIncome.textContent =
                "$" + Number(louisville.median_income).toLocaleString("en-US");

            povertyRate.textContent =
                Number(louisville.poverty_percent) + "%";

        });
}


// --- DROPDOWN MENU ---
// Retrieve the available cities for comparison
fetch("/api/cities")
    .then(response => response.json())
    .then(data => {

        const dropdown = document.querySelectorAll(".city-option"); // querySelector uses .class

        // loop for each dropdown menu
        dropdown.forEach(select => { // go through each dropdown
            const option = document.createElement("option"); //
            option.textContent = "Select a city";
            option.value = "";
            select.appendChild(option);

            // loop to list all 10 cities
            data.forEach(city => {

                const option = document.createElement("option");
                option.textContent = city.city_name;
                option.value = city.city_name;
                select.appendChild(option); // parent.appendChild(child)
            });

            // Change event listener goes off every time the user changes their option
            select.addEventListener("change", () => {

                const selectedCity = Array.from(dropdown)
                    .map(select => select.value)// transforms each item and makes new array
                    .filter(value => value !== ""); // subset of an original array; filters based on some condition -> these two work together

                // Preventing duplicate selections
                dropdown.forEach(select => {
                    Array.from(select.options).forEach(option => {
                        option.disabled =
                            option.value !== "" &&
                            option.value !== select.value &&
                            selectedCity.includes(option.value);
                    });
                });

            });
        });
    })
    .catch(error => {
        console.log("Error finding cities", error);
    });

// --- COMPARE BUTTON ---
    const compareButton = document.getElementById("compare-button");


    compareButton.addEventListener("click", () => {
       //temp: console.log("compare button clicked");

        const dropdown = document.querySelectorAll(".city-option");

        const selectedCity = Array.from(dropdown)
            .map(select => select.value)
            .filter(value => value !== "");

        if (selectedCity.length < 2) {
            alert("Please select two or more cities");
            return;
        }

        const selectedData = cities.filter(city =>
            selectedCity.includes(city.city_name)
        );

        console.log("Selected city data:", selectedData);

        console.log("Selected city", selectedCity);

        // --- DYNAMICALLY ADDING DATA TO TABLE ---
        // -- city names
            const headerRow = document.getElementById("compare-header-row");
            headerRow.replaceChildren(document.createElement("th"));

            selectedCity.forEach(city => {
                const th = document.createElement("th");
                th.textContent = city;
                headerRow.appendChild(th);
            });



        // all other stats
        const rows = document.querySelectorAll("#comparison-body tr"); // find all <tr> under id #comparison-body

        rows.forEach(row => {
            const field = row.dataset.field;

            row.querySelectorAll("td").forEach(td => td.remove());

            // Go through each selected city
            selectedCity.forEach(cityName => {

                const city = selectedData.find(city =>
                    city.city_name === cityName
                );

                const td = document.createElement("td");


                if (city) {
                    const value = city[field];


                    if (value === null || value === undefined) {
                        td.textContent = "N/A";
                    } else if (field === "population") {
                        td.textContent = Number(value).toLocaleString("en-US");
                    } else if (field === "median_income" ||
                        field === "median_gross_rent") {
                        td.textContent = "$" + Number(value).toLocaleString("en-US");
                    } else if (field === "violent_crime_rate" ||
                        field === "property_crime_rate") {
                        td.textContent = Number(value).toLocaleString("en-US", {
                            minimumFractionDigits: 1,
                            maximumFractionDigits: 1
                        });
                    } else {
                        td.textContent = Number(value).toFixed(1) + "%";
                    }
                } else {
                    td.textContent = "N/A";
                }

                row.appendChild(td);
            });
        });
// linking to description buttons
        comparedCities = selectedCity.map(cityName =>
            selectedData.find(city => city.city_name === cityName)
        ).filter(city => city !== undefined);

        currentCity = 1;

        if (comparedCities.length > 0) {
            cityName.textContent = comparedCities[0].city_name;
            cityText.textContent = comparedCities[0].description;
            cityCounter.textContent = `City 1 of ${comparedCities.length}`;
        }


    })




// --- CLEAR BUTTON ---
    const clearButton = document.getElementById("clear-button");
    clearButton.addEventListener("click", () => {

        const dropdown = document.querySelectorAll(".city-option");
        dropdown.forEach(select => {
            select.value = "";

            Array.from(select.options).forEach(option => {
                option.disabled = false;
            })
        })

        console.log("clear value")

    })

