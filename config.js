var config = {
    address: "0.0.0.0",
    port: 8080,
    basePath: "/",
    ipWhitelist: [],
    useHttps: false,
    language: "en",
    locale: "en-AU",
    logLevel: ["INFO", "LOG", "WARN", "ERROR"],
    timeFormat: 12,
    units: "metric",

    modules: [
        {
            module: "alert",
        },
        {
            module: "updatenotification",
            position: "top_bar"
        },
        {
            module: "clock",
            position: "top_left",
            config: {
                dateFormat: "dddd, MMMM D, YYYY",
                showPeriodUpper: true
            }
        },
        {
            module: "calendar",
            header: "Australian Holidays",
            position: "top_left",
            config: {
                calendars: [
                    {
                        symbol: "calendar-check",
                        url: "https://google.com"
                    }
                ]
            }
        },
        {
            module: "weather",
            position: "top_right",
            config: {
                weatherProvider: "openweathermap",
                type: "current",
                location: "Brisbane",
                locationID: "2174003",
                apiKey: "YOUR_OPENWEATHER_API_KEY" // <--- PASTE YOUR API KEY HERE
            }
        },
        {
            module: "weather",
            position: "top_right",
            header: "Weather Forecast",
            config: {
                weatherProvider: "openweathermap",
                type: "forecast",
                location: "Brisbane",
                locationID: "2174003",
                apiKey: "YOUR_OPENWEATHER_API_KEY" // <--- PASTE YOUR API KEY HERE
            }
        }
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") { module.exports = config; }
