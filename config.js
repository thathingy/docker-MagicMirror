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
            module: "compliments",
            position: "top_left",
            config: {
                weatherWithCompliments: true,
                compliments: {
                    anytime: ["Ready for a great day at Churchie!"],
                    day_sunny: ["Clear blue skies! Remember your sunnies. 😎"],
                    day_cloudy: ["Bit overcast out there today."],
                    rain: ["Rain predicted! Pack an umbrella. 🌧️☔"],
                    thunderstorm: ["Stormy outside! Stay safe. ⚡⛈️"],
                    "below_18": ["Chilly morning! Grab your school jumper. 🧥"],
                    "above_25": ["Warm day ahead! Keep hydrated. ☀️"]
                }
            }
        },
        {
            module: "calendar",
            header: "7-Day Weekly Timetable",
            position: "top_left",
            config: {
                colored: true,
                coloredSymbols: false,
                displaySymbol: false,
                showLocation: false,
                maxResults: 8,
                fade: false,
                maxTitleLength: 28,
                timeFormat: "absolute",
                urgency: 7,
                showEnd: true,
                getRelative: 0,
                sliceMultiDayEvents: false,
                showFullDayEvents: false,
                calendars: [
                    {
                        color: "#5cc2f2", 
                        url: "https://calendar.google.com/calendar/ical/1382abd753f572abe42c619efb9ee71576d680fd38f5661f4711b23cd3f6d0fd%40group.calendar.google.com/private-ec5db411e0b36493eaa1124c0ddb1565/basic.ics"
                    },
                    {
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
                weatherProvider: "openmeteo",
                type: "current",
                lat: -27.4705,
                lon: 153.0260,
                showPrecipitationProbability: true,
                showWindDirection: false,
                showHumidity: true
            }
        },
        {
            module: "weather",
            position: "top_right",
            header: "7-Day Forecast Insights",
            config: {
                weatherProvider: "openmeteo",
                type: "forecast",
                lat: -27.4705,
                lon: 153.0260,
                showPrecipitationProbability: true,
                fade: false,                  // ❌ Disables layout fading for the forecast rows
                fadePoint: 1,                 // Forces 100% brightness for all elements
                maxNumberOfDays: 7            // 📅 Extends the display out to show all 7 days
            }
        }
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") { module.exports = config; }
