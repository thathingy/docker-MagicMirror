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
            module: "clock",
            position: "top_left",
            config: {
                dateFormat: "dddd, MMMM D, YYYY",
                showPeriodUpper: true,
                displaySeconds: false
            }
        },
        {
            module: "calendar",
            header: "Schedule Overview",
            position: "top_left",
            config: {
                colored: true,
                coloredSymbols: true,
                showLocation: false,
                maxResults: 10,
                fade: false,            // ❌ This stops the fading effect completely
                fadePoint: 1,           // Forces all lines to stay at 100% brightness
                maxTitleLength: 35,     // Gives long school event names more room before cutting off
                calendars: [
                    {
                        symbol: "google",
                        color: "#4285F4", // Clean blue tracking
                        url: "https://calendar.google.com/calendar/ical/1382abd753f572abe42c619efb9ee71576d680fd38f5661f4711b23cd3f6d0fd%40group.calendar.google.com/private-ec5db411e0b36493eaa1124c0ddb1565/basic.ics"
                    },
                    {
                        symbol: "graduation-cap",
                        color: "#FFD700", // Churchie Gold tracking
                        url: "https://my.churchie.com.au/calendar/export.php?export=all&event_type=&token=3ee8dffe24a12abfc929b4a70"
                    }
                ]
            }
        },
        {
            module: "weather",
            position: "top_right",
            config: {
                weatherProvider: "openmeteo",
                type: "current",
                lat: -27.4705,
                lon: 153.0260
            }
        },
        {
            module: "weather",
            position: "top_right",
            header: "5-Day Forecast",
            config: {
                weatherProvider: "openmeteo",
                type: "forecast",
                lat: -27.4705,
                lon: 153.0260
            }
        }
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") { module.exports = config; }
