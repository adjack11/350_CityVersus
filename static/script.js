// EMPTY ARRAY THAT PULLS FROM DATABASE - TEMPORARY
let cities = [];

fetch("/api/cities") // Sends HTTP request to Flask
    .then(response => response.json()) // Flask reads JSON and parses it into JS
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

// --- NEXT DESCRIPTION BUTTON ---
const nextButton = document.getElementById("next-city");
if(nextButton){
    nextButton.addEventListener("click", function() {
        cityName.textContent = cities[currentCity - 1];
        // Keeps from exceeding 5; anything over 5 will go to the first description
        if (currentCity >= 5) {
            currentCity = 1;
        } else {
            currentCity++
        }
        cityName.textContent = cities[currentCity - 1].name;
        cityText.textContent = cities[currentCity - 1].description;
        cityCounter.textContent = `City ${currentCity} of 5`;
    });
}

// --- PREVIOUS DESCRIPTION BUTTON ---
const prevButton = document.getElementById("prev-city");
if (prevButton){
    prevButton.addEventListener("click", function() {
        cityName.textContent = cities[currentCity - 1];
        // Keeps from becoming less than one; anything below will go to the first description
        if (currentCity <= 1) {
            currentCity = 5;
        } else {
            currentCity--;
        }
        cityName.textContent = cities[currentCity - 1].name;
        cityText.textContent = cities[currentCity - 1].description;
        cityCounter.textContent = `City ${currentCity} of 5`;
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
