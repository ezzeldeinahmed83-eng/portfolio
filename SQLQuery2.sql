


USE Network;

-- 1- Towers
CREATE TABLE towers (
    tower_id INT PRIMARY KEY,
    tower_name VARCHAR(50)
)

INSERT INTO towers
SELECT DISTINCT
    tower_id,
    CONCAT('Tower-', tower_id)
FROM Telecom_Network_Data
WHERE tower_id IS NOT NULL

select * from towers


-- 2- Weather

CREATE TABLE weather_conditions (
    weather_id INT IDENTITY PRIMARY KEY,
    weather_type VARCHAR(20) UNIQUE
)

INSERT INTO weather_conditions (weather_type)
SELECT DISTINCT weather
FROM Telecom_Network_Data
WHERE weather IS NOT NULL

select * from weather_conditions


-- 3. Network Readings
CREATE TABLE network_readings (
    reading_id INT IDENTITY PRIMARY KEY,
    reading_timestamp DATETIME,
    tower_id INT,
    users_connected INT,
    download_speed FLOAT,
    upload_speed FLOAT,
    latency FLOAT,
    weather_id INT,
    congestion BIT,

    FOREIGN KEY (tower_id) REFERENCES towers(tower_id),
    FOREIGN KEY (weather_id) REFERENCES weather_conditions(weather_id)
)


-- Insert readings
-- d=> raw data .csv

INSERT INTO network_readings
SELECT
    d.timestamp,
    d.tower_id,
    d.users_connected,
    d.download_speed,
    d.upload_speed,
    d.latency,
    w.weather_id,
    d.congestion
FROM Telecom_Network_Data d
LEFT JOIN weather_conditions w
    ON d.weather = w.weather_type;

    select * from network_readings