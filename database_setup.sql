-- CREATING DATABASE
CREATE DATABASE major_cities;
USE major_cities;

-- CITY STATS SCHEMA
CREATE TABLE cities (
                        city_id INT PRIMARY KEY AUTO_INCREMENT,
                        city_name VARCHAR(30),
                        state CHAR(2),

                        population INT,
                        white_percent DECIMAL(5,2),
                        black_percent DECIMAL(5,2),
                        american_indian_percent DECIMAL(5,2),
                        asian_percent DECIMAL(5,2),
                        pacific_islander_percent DECIMAL(5,2),
    -- two or more races
                        two_plus_races_percent DECIMAL(5,2),
                        hispanic_percent DECIMAL(5,2),

                        median_income INT,
                        median_gross_rent INT,
                        median_monthly_owner_cost INT,
                        unemployment_rate DECIMAL(5,2),

                        uninsured_percent DECIMAL(5,2),
                        poverty_percent DECIMAL(5,2),

                        violent_crime_rate DECIMAL(8,2),
                        property_crime_rate DECIMAL(8,2)
);

-- INSERT CITY STATISTICS
INSERT INTO cities (
    city_id,
    city_name,
    state,
    population,
    white_percent,
    black_percent,
    american_indian_percent,
    asian_percent,
    pacific_islander_percent,
    two_plus_races_percent,
    hispanic_percent,
    median_income,
    median_gross_rent,
    median_monthly_owner_cost,
    unemployment_rate,
    uninsured_percent,
    poverty_percent,
    violent_crime_rate,
    property_crime_rate
)
VALUES
    (1, 'Louisville', 'KY', 641962, 60.7, 22.4, 0.2, 2.9, 0, 11, 9.5, 66849, 1120, 1555, 4.8, 7, 15.8, 707.4, 3326.2),
    (2, 'Cincinnati', 'OH', 314367, 49, 36.5, 0.2, 2.7, 0, 9, 6.1, 52909, 1001, 1640, 3.7, 8.9, 25.5, 845.6, 3829.3),
    (3, 'Columbus', 'OH', 938396, 51.7, 29.3, 0.3, 6, 0, 9.1, 8.3, 66082, 1295, 1599, 3.2, 11.4, 18.1, 435, 2653.3),
    (4, 'Cleveland', 'OH', 363608, 35.5, 45.9, 0.3, 2.6, 0, 10.5, 13.2, 40801, 945, 1193, 3.1, 9.3, 30.6, 1561.1, 4426.3),
    (5, 'Indianapolis', 'IN', 901116, 51.3, 27.9, 0.6, 4.2, 0, 9.7, 13.8, 66219, 1156, 1462, 3.4, 10, 15.8, 877.9, 3336.1),
    (6, 'St. Louis', 'MO', 278144, 45.5, 42.3, 0.3, 3.5, 0, 6.5, 5.3, 56160, 997, 1487, 3.8, 10.9, 20.6, 1367.1, 5706.9),
    (7, 'Detroit', 'MI', 649095, 11.6, 75.3, 0.4, 1.7, 0, 6, 8.3, 39938, 1074, 1238, 6, 8.5, 32.7, 1781.3, 4305.3),
    (8, 'Memphis', 'TN', 609647, 23.8, 62.9, 0.5, 1.7, 0.1, 5.5, 10.4, 51736, 1181, 1420, 4.7, 16.9, 23.1, 2501.3, 6899),
    (9, 'Nashville', 'TN', 721074, 54.6, 24.9, 0.5, 3.5, 0.1, 11.2, 14.1, 77371, 1586, 1898, 3, 14.4, 14.1, 1124.1, 4509.5),
    (10, 'Chicago', 'IL', 2731585, 36, 27.9, 1.1, 7.3, 0.1, 13.9, 29.7, 77902, 1440, 2339, 4.9, 11, 16.8, 540, 3472.4);

SELECT * FROM cities;

-- CITY DESCRIPTIONS SCHEMA
CREATE TABLE city_description (
                                  city_id INT PRIMARY KEY,
                                  description TEXT,
                                  FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- INSERTING CITY DESCRIPTIONS
INSERT INTO city_description (city_id, description)
VALUES
    (1, 'Louisville is Kentucky''s largest city, situated along the Ohio River and serving as a cultural crossroad between the Midwest and Upper South. Its identity is anchored by bourbon heritage, legendary horse racing traditions, historic cast-iron architecture, and an acclaimed independent culinary scene.

The cost of living remains consistently below national standards, delivering strong housing affordability across both historic urban districts and suburban developments. This cost advantage provides a high standard of living for moderate income levels.

Most residents commute by personal automobile, though central neighborhoods such as the Highlands, NuLu, and Old Louisville feature walkable streets and local bus coverage. The climate features hot summers and moderately cold winters, appealing to food and spirits enthusiasts, logistics specialists, healthcare workers, and families seeking historic charm.'),

    (2, 'Cincinnati is a historic tri-state hub defined by its dramatic hill-and-river geography, deep German heritage, and prominent corporate footprint. The general vibe balances European-inspired architectural charm and rich arts traditions—such as its famous symphony and theater districts—with a passionate local sports culture and distinctive food identity.

Living expenses remain competitive and comfortably below national averages. Its diverse housing stock ranges from historic brick townhomes in historic districts to affordable suburban single-family residences.

While the region''s steep topography and sprawling footprint necessitate a car, inner neighborhoods like Over-the-Rhine and Downtown offer high walkability supported by the Bell Connector streetcar. Seasons range from warm, humid summers to moderately cold winters, appealing to corporate professionals, arts advocates, historic preservationists, and young families.'),

    (3, 'Columbus is a fast-growing, tech-forward Midwest hub characterized by a youthful, pragmatic, and modern vibe. Anchored by Ohio State University and a booming corporate sector across finance, retail, and tech, the city balances smart suburban growth with expanding urban neighborhoods.

The cost of living sits right around the national average, making it an accessible growth city compared to coastal tech markets. While housing costs have steadily risen due to population inflows, homeownership and rental options remain highly approachable for young professionals and expanding families.

Daily life relies primarily on personal automobiles, though inner-ring districts like the Short North, German Village, and University District offer concentrated walkability and bike paths. The region experiences four distinct seasons, featuring warm summers and moderately cold winters, making it an ideal destination for young professionals, tech workers, corporate relocators, and growing families.'),

    (4, 'Cleveland is a resilient Rust Belt city along Lake Erie defined by a deep industrial heritage, strong civic pride, and a burgeoning cultural and medical sector. The vibe blends working-class authenticity with world-class cultural institutions like the Cleveland Orchestra, Playhouse Square, and the Cleveland Clinic.

The city stands as one of the most affordable major metro markets in the nation. Highly competitive housing prices and low baseline living expenses allow residents to achieve homeownership far more easily than in larger metropolitan areas.

While suburban sprawl makes car ownership standard for most commuters, inner neighborhoods like Tremont, Ohio City, and Downtown feature historic streetscapes and high walkability, complemented by RTA transit links. Lake Erie creates variable, snowy winters alongside pleasant, temperate summers, appealing to healthcare professionals, culture enthusiasts, remote workers, and cost-conscious buyers.'),

    (5, 'Indianapolis is a planned, grid-layout capital city in central Indiana recognized for its major sports hosting infrastructure, racing heritage, and central transportation logistics. The city vibe is welcoming, practical, and civic-minded, blending a clean, walkable downtown core with quiet, family-oriented suburban neighborhoods.

It offers an attractive, low-cost baseline with housing affordability well above the national average. Homeownership is highly attainable for first-time buyers, making it one of the most accessible major metros in the region.

The overall metro layout relies on car travel, but the downtown district is famously compact and walkable, featuring the iconic Cultural Trail for pedestrian and bicycle commuting. The city encounters four full seasons with cold winters and warm summers, making it an ideal home for sports industry workers, corporate managers, young families, and practical professionals.'),

    (6, 'St. Louis is a historic Mississippi River city recognized for its grand 19th-century architecture, vibrant neighborhood culture, and major legacy industries in bioscience, healthcare, and finance. The city carries a warm, proud, Midwestern-meets-Southern vibe centered on community traditions, local sports, and expansive public parks.

Affordability is a major draw, offering housing costs well below national benchmarks. Buyers and renters can secure historic brick homes and modern urban apartments at price points significantly lower than coastal or high-growth sunbelt markets.

A car is essential for general metro travel, though historic enclaves like Central West End, Soulard, and the Loop provide localized walkability alongside Light Rail (Metrolink) connections. Summers are hot and humid while winters are moderately cold and brief, attracting medical researchers, young families, lovers of historic architecture, and budget-minded professionals.'),

    (7, 'Detroit is an iconic American industrial power center undergoing a dynamic urban revitalization anchored by tech, design, mobility, and arts investments. The overall vibe is defined by creative energy, historical grit, deep musical and automotive roots, and a fiercely loyal local community.

Living costs remain exceptionally low compared to major metropolitan centers across the country. Detroit provides remarkable real estate value, offering affordable entry points for home renovation, property investment, and low-cost urban rentals.

Car transit is central to daily life in the Motor City, though Downtown, Midtown, and Corktown have become highly walkable corridors served by options like the QLine streetcar. Experiences range from snowy winters to warm, sunny summers, catering to entrepreneurs, artists, tradespeople, auto/tech engineers, and urban pioneers looking to build equity.'),

    (8, 'Memphis is a soulful, culturally rich city along the Mississippi River renowned world-wide for its monumental influence on blues, rock, and soul music, as well as its world-class logistics industry. The vibe is laid-back, authentic, and expressive, grounded in musical heritage, celebrated barbecue culture, and strong community roots.

The region offers a remarkably low cost of living, with housing costs consistently tracking far below national metrics. Generous purchasing power allows both young buyers and families to obtain spacious housing affordably.

The urban footprint requires a car for primary transportation, though historic districts such as Downtown, Midtown, and Cooper-Young offer distinct walkable pockets. The climate trends humid subtropical, featuring mild winters and hot, humid summers, making it ideal for logistics professionals, musicians, creatives, and budget-conscious households seeking Southern warmth.'),

    (9, 'Nashville is a booming Southern powerhouse and the world capital of country music, known for its rapid growth, thriving tourism, and expanding healthcare, finance, and tech economies. The city vibe is high-energy, entrepreneurial, and entertaining, blending traditional Southern charm with a fast-paced creative industry.

Rapid economic expansion has elevated the cost of living above the national average, particularly within housing and rent across central neighborhoods. However, the absence of a Tennessee state income tax helps offset higher real estate entry points.

Car commuting is standard across the broader metropolitan area, though core districts like the Gulch, East Nashville, and 12 South provide lively, walkable streetscapes. Summers are warm and long, accompanied by mild winters, drawing healthcare executives, music industry professionals, young creatives, and corporate transplants.'),

    (10, 'Chicago is the premier economic and cultural metropolis of the Midwest, boasting world-renowned architecture, global finance, rich arts institutions, and a vast lakefront. The vibe is big-city dynamic yet approachable, balancing intense urban hustle with grounded, neighborhood-centric community identity.

While the cost of living is noticeably higher than regional Midwestern peers, it remains remarkably affordable compared to global coastal hubs like New York or San Francisco. Housing costs vary widely, offering luxury high-rises down to accessible neighborhood two-flats.

It features elite public transit via the CTA elevated train and bus network, enabling true car-free living across highly walkable, dense neighborhoods. The city experiences hot summers along Lake Michigan and famously cold, snowy winters, targeting career-driven professionals, urbanites, corporate leaders, and lovers of high-density city living.');