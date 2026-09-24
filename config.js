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
            module: "alert"
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
            header: "Daily Schedule",
            position: "top_left",
            config: {
                calendars: [
                    {
                        symbol: "google",
                        color: "#4285F4",
                        url: "https://calendar.google.com/calendar/ical/1382abd753f572abe42c619efb9ee71576d680fd38f5661f4711b23cd3f6d0fd%40group.calendar.google.com/private-ec5db411e0b36493eaa1124c0ddb1565/basic.ics"
                    },
                    {
                        symbol: "school",
                        color: "#FFD700",
                        url: "https://my.churchie.com.au/calendar/export.php?export=all&event_type=&token=3ee8dffe24a12abfc929b4a70"
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
                apiKey: "bd0fbb67cca795da7e980b26ae14acfd"
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
                apiKey: "bd0fbb67cca795da7e980b26ae14acfd"
            }
        }
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") { module.exports = config; }
