return {
    "~/gitclone/ppebboard", -- Dashboard
    config = function()
        local function startup_time()
            local startup_file_path = "/tmp/startuptime" -- Path set by alias nvim --startuptime /tmp/startuptime
            local startup_time_pattern = "([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+"

            local startup_time_file = io.open(startup_file_path) and io.open(startup_file_path):read("*all") or nil

            if not startup_time_file then
                return "unknown"
            end

            local time = startup_file_path and tonumber(startup_time_file:match(startup_time_pattern)) or nil

            io.open(startup_file_path, "w"):close()

            return time or "unknown"
        end

        local cfg = {
            header = {
                lines = {
                    "",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢁⣰⢉⣱⣿⣿⠉⢁⣾⣿⡿⢏⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠰⠶⡆⠰⠄⠄⠉⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣾⠹⢿⣷⡆⢷⣶⣸⣿⣿⣿⣿⡿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⡏⢁⡏⢁⣿⣿⡿⢏⣾⣿⣿⡿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⢈⡉⣏⣩⠄⠄⠄⠄⠄⠄⠄⠰⠆⠄⠄⠄⠄⢀⠸⠿⣇⣈⢹⣷⠘⢹⣿⣿⡏⠉⠁⢀⠄⠄⠄⠄⣀⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⠄⠄⠄⠄⠈⠁⢰⡆⣴⣾⣿⡏⣴⣾⣿⣿⠃⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡗⢸⡗⡟⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣤⡌⠙⣶⡆⠙⢻⣾⣿⡆⠐⡟⠛⠄⠄⠄⠄⠄⠄⠄⠄⡇⢸⣦⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠃⠄⠄⠄⠄⠄⠄⠄⠄⢡⣼⣿⣿⢡⣼⣿⣿⡟⠋⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠈⠁⠃⠄⠄⠄⠄⠄⠄⠄⢠⣤⡆⢠⠐⠊⠃⢠⡌⠉⠂⠄⠛⢻⠁⠄⠁⢠⢠⣴⣴⣦⣯⣽⢺⡇⣷⣾⣿⣿⣿⣯⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠄⠄⠄⠄⠄⠄⠄⠄⠂⠄⢸⣿⣿⡟⢸⣿⣿⡏⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠉⠉⠁⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⢠⣤⣼⣿⣿⣿⣿⣿⣿⣷⡄⠄⠄⠐⢲⣶⠄⠐⣤⡄⢰⡖⡍⢹⣽⡏⡟⢻⣿⣯⣿⣿⣿⣿⣿⣿⣷⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣿⣿⡏⢡⣿⣿⡇⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠈⠁⡅⠄⠊⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠁⠉⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣦⣼⣿⣿⠃⢸⣿⡟⢰⡞⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣤⡄⠄⠄⠄⠄⠄⠄⠄⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡄⣷⣦⠄⠄⢠⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠿⢿⣿⡏⣸⣿⠁⠄⠁⠄⠄⠄⠄⠄⠛⢻⣿⣿⣿⣿⣿⡗⣀⣠⡀⠄⠄⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⠻⠿⣿⣿⣿⡟⠛⢻⠛⠛⡟⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢹⣿⡆⠄⠁⠄⣷⣶⢰⣶⣦⡄⠄⢐⠄⠄⣀⣀⣤⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⠛⠋⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⡇⡿⠏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⢿⣿⣿⣿⢏⣡⣿⣿⣷⣦⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⠈⠉⣿⣿⣿⣿⣿⡟⠄⠄⡿⠿⢿⡧⠤⢼⠄⠄⡇⠄⢸⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⡟⠇⠄⠄⠄⠉⠙⠎⠉⠉⠁⠄⠈⠄⠄⠙⠛⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣼⣿⡇⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⢿⡿⠏⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⢿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠛⢻⠛⠋⡉⠉⢹⡏⠉⢩⠉⠉⡏⠉⢡⡌⠉⢹⠍⠉⠉⠉⠹⢿⠄⠄⣭⣽⣿⣿⣿⣷⠄⠄⡇⠄⢸⡇⠄⢸⠄⠄⡇⠄⢸⣿⣿⣿⣿⣿⠄⢀⡆⠄⣰⡆⠈⢹⠛⠋⡄⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠓⠘⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠒⠂⠂⠄⠄⠄⠄⠄⠈⠉⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣀⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⢻⣿⡇⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠃⢰⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⢹⡇⠉⢹⠈⠁⡄⠈⢹⡏⠉⢹⠉⠉⣿⣿⣿⣿⡇⠄⢰⡆⠄⢸⣤⡤⠁⠄⢘⡃⠄⢸⠄⠄⡇⠄⢸⡇⠄⢸⠄⠄⣲⡆⠐⢚⠄⠄⣿⣿⣿⣿⣿⣿⠄⠄⠁⠠⢼⡇⠄⢸⠄⠄⠧⠄⠸⢿⣿⣿⣿⣿⠄⠈⡇⠄⢹⡇⠄⢸⠄⠄⠇⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⡿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡀⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⢸⡇⠄⢈⠄⠄⡇⠄⢸⡇⠄⢸⠄⠄⣿⣿⣿⣿⡇⠄⢸⣷⣶⣾⠉⠁⡀⠄⠸⠇⠄⢸⠄⠄⡇⠄⢸⡇⠄⠨⠄⠄⠍⠁⠠⢼⠄⠄⣿⣿⣿⣿⣿⣿⠄⠄⡆⠄⢘⡃⠄⢘⡀⠄⢲⡆⠄⢸⣿⣿⣿⣿⠄⠄⡇⠄⢸⡇⠄⢸⠄⠄⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⣀⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡄⠄⠄⠄⠄⠄⠄⠈⠉⠉⠉⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⢐⣲⣶⣶⣶⡾⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⢌⡁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢀⠸⠇⠄⢸⠄⠄⡇⠄⢸⡇⠄⠸⠄⠄⣿⣿⣿⣿⡇⠄⠸⠏⠉⠹⠄⠄⠇⠄⢐⡂⠄⢸⠄⠄⡇⠄⢸⣇⠄⢰⠄⠄⢒⣂⣰⣾⠄⠄⣿⣿⣿⣿⣿⣿⠄⠄⡇⠄⢸⡇⠄⢨⡅⠄⢸⡇⠄⢸⣿⣿⣿⣿⠄⠄⣇⡀⢸⣇⠄⢸⡄⢀⣛⣋⣙⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠄⠉⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠃⠄⠄⠄⠄⠄⠠⢄⠄⠄⠄⠄⠰⠾⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠇⠄⠄⠄⢀⣿⣿⣿⣿⠟⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⡄⣟⣻⢻⣇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⡀⠄⢸⠄⠄⢃⣠⣸⡇⠄⠄⠄⠄⣿⣿⣿⣿⣇⣀⣀⣀⣀⣸⣤⣤⣤⣤⣼⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣧⣤⣼⣿⣿⣿⣿⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠄⠄⠄⠄⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠄⠄⠄⠄⢸⣿⣿⣿⡿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⡇⡿⢿⢘⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠇⣀⣸⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⠛⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⠃⠘⠘⠃⠃⠄⡃⢀⠻⢿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⣸⣿⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⡇⡟⢻⣿⡧⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣠⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⢀⣿⣿⡿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣘⡃⡃⢸⢸⡿⡘⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠄⠘⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⡄⠄⠄⡀⠄⣀⡀⠄⠄⣼⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⠄⠄⠄⢸⣿⣿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⢾⡷⡀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⢸⡏⠉⢉⠉⠉⣿⣿⣿⣿⣿⡇⠄⢰⠄⠈⣿⣿⣿⣿⣿⡏⢿⣿⣿⣿⡿⠿⢿⡿⠉⠉⠉⠉⡏⠉⢹⡏⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⢀⡀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠰⠆⠶⠶⠄⠄⠄⠄⠄⠄⠄⠄⢰⣆⡿⠏⣈⣉⣰⣾⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⠉⠉⠄⠄⠄⠄⢿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠸⠇⡇⠄⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⢸⡇⠄⢰⠄⠄⢾⣿⣿⣿⣿⣿⡇⠄⠄⠄⣿⣿⣿⣿⡷⠆⢸⣿⣿⣿⡇⠄⢸⣷⣶⡾⠄⠄⡆⠄⠸⠇⠄⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⠈⠁⠄⠄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⢸⢈⣁⣿⣷⡀⠄⠄⠄⠄⠄⢈⣹⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⡿⠄⠄⠄⠄⠄⠄⠄⠄⢸⣇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠇⢸⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⢀⡀⠄⠈⠄⠄⣾⣿⣿⣿⡿⠇⠄⢰⠄⠄⣿⣿⣿⣿⣿⡇⢸⣿⠹⠿⡇⠄⢸⡏⠁⠄⠄⠄⡇⠄⠄⠄⠄⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠄⠄⠄⢀⡀⠄⢀⣀⣇⣀⡀⠄⠄⠄⣶⡶⣀⣰⡀⠄⠄⠄⠄⠄⠄⠄⢸⣷⣇⣸⣿⣿⣿⣿⣷⣆⡀⢀⣰⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⣿⣿⡆⠄⣶⣶⠆⢀⠄⠄⠄⠄⠄⠄⣀⣰⣶⡆⢰⣶⡀⠄⠄⠈⣀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠄⠄⠄⠄⢀⠄⠄⣿⣿⣿⣿⣿⡇⠄⠸⠄⠄⣿⣿⣿⣿⣿⡇⠰⠾⠄⠄⠇⠄⢸⡇⠄⠄⠄⠄⣿⣷⣶⣆⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣆⣀⡈⠄⢈⣿⣏⣉⣹⣏⣁⣀⣸⣿⣇⡆⠄⠄⢀⢰⡆⠄⠄⠄⠄⢾⣷⢿⡿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠄⢹⡏⢸⣏⣹⣿⡇⢸⣿⣿⣿⣿⣿⡇⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣾⣷⣶⣾⣾⣿⣿⣿⣿⣿⣿⣷⣷⣶⣶⣶⣿⣿⣿⣿⣿⣷⣶⣶⣿⣿⣆⣰⣸⣷⣆⣰⣶⣶⣿⡿⠿⠿⢀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠏⠄⠄⠄⠄⠇⠄⠄⠄⠄⠈⠹⢿⣿⣿⣇⣀⡿⠏⠈⠁⠄⠄⠁⠄⣏⣹⣿⣿⢹⣿⣏⣹⠹⢿⣿⣏⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣧⠄⠄⣿⣿⢰⣾⣿⣿⣿⣿⡟⠃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣦⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠄⠄⠁⠄⠄⠄⢠⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠉⠁⠄⠄⠄⠄⠄⠄⠄⠓⠊⠊⠙⠄⠄⢸⡏⡆⠘⣿⣿⢳⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡌⢱⠂⢠⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⡇⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠁⠄⠄⡄⠄⠈⢩⣭⡅⠈⠙⠛⠛⠉⢩⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⡏⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⣶⡆⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⠁⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⢩⣽⣿⡇⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⠃⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠘⣿⣿⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢻⣿⡟⢻⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢲⡆⠄⠄⠄⠈⠄⠄⢰⣦⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡍⢹⣧⣼⢰⡆⡄⠄⢸⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠈⡟⠃⠄⠈⠉⠉⡏⠉⠉⠉⠉⠉⡄⠄⢠⣴⣿⣿⣿⣿⣿⡏⠉⢡⡌⠉⣤⡌⠙⢻⠉⠉⣭⡍⢹⣿⠄⠄⣼⣿⠄⠄⣴⣾⡟⠛⠁⠄⠄⢸⠄⠄⣶⣾⡄⠄⢰⣦⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠐⠒⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠁⠄⠄⡇⠄⠄⠄⢸⣧⡄⠄⠄⠄⠄⠄⠈⠉⠄⠄⠄⠄⢠⣼⣽⣿⣷⡞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⡿⠏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣹⣿⣐⡂⣆⣠⡛⠻⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⡿⠟⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠠⢼⡯⠅⠄⢸⠄⠄⣷⣶⠾⠇⠄⠄⡇⠄⢸⣿⣿⣿⣿⣿⣿⡇⠄⢸⡂⠄⣾⡇⠄⢸⣶⣶⠇⠄⢘⣻⠄⠄⣿⣿⡆⠄⣿⣿⡇⠄⠸⠇⠄⢸⠄⠄⢿⣿⣧⣤⣌⡉⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠐⠊⠁⠄⠄⢠⡿⢿⣇⡀⠄⠄⠄⠐⠄⢀⢀⡀⣀⣐⣆⣸⣺⣿⣿⣧⡹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⡇⠄⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠄⠈⠙⠛⢽⡇⡯⢽⠅⢰⢹⣿⣿⣿⢸⣿⣿⣿⣿⣿⠁⠄⠄⠄⠈⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡀⠄⢸⣷⡆⠄⢘⠄⠄⡟⠛⠄⠄⠄⠄⡇⠄⢸⣿⣿⣿⣿⣿⣿⡇⠄⢸⡇⠄⢽⡇⠄⢸⠉⠉⠠⠄⠨⢽⠄⠄⣿⣿⡇⠄⣿⣿⡇⠄⢠⣤⣶⣾⠄⠄⢺⣿⣿⣿⣿⡇⠄⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠄⠄⠄⠄⠄⠄⠄⠰⢀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠂⢐⠐⠂⠄⠄⡀⠘⣃⣈⢻⡇⠄⠄⠂⠄⠄⢘⢨⡥⢩⣍⣿⣿⣿⣿⣽⣿⡧⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⠇⣇⣸⡶⢾⢸⡏⡻⠿⠈⢹⣿⣿⣿⡿⠄⠄⠄⠄⠄⠄⠘⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⢸⣿⡇⠄⠨⠄⠄⠁⠄⠄⠠⠄⠄⡇⠄⢸⣿⣿⣿⣿⣿⣿⡇⠄⢸⡇⠄⣺⡇⠄⢸⠄⠄⢠⡄⠄⢸⠄⠄⣿⣿⡇⠄⣿⣿⡇⠄⢸⡟⠛⢻⡂⠄⢸⣿⡏⠉⠙⠃⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣀⠄⠄⠄⠄⠄⠄⠈⠁⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠄⠈⢀⣠⢰⡆⡇⢀⠉⢹⠨⠅⠠⠄⠄⠄⠄⢸⢨⡥⣾⣏⡯⢽⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠂⠛⠋⠁⠘⢸⡇⡃⠄⠄⠘⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡀⠘⢿⣇⣀⣰⣀⣀⣰⣆⣀⣀⣀⣀⣇⣠⣈⣙⣿⣿⣿⣿⣿⣧⣀⣸⣇⣠⣿⣇⣤⣼⣆⣀⣈⣡⣤⣼⣤⣤⣭⣽⣧⣤⣭⣽⣧⣤⣬⣥⣤⣼⣧⣤⢼⣿⣧⣴⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣤⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣤⣦⡄⢺⣿⢸⡇⠇⠸⡄⠘⠄⠄⢐⡂⣖⣲⡂⢸⣺⣗⣿⣿⣗⣺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠄⠄⠨⠅⠁⢠⣤⡄⢹⣿⣿⣿⠄⠄⠄⠄⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣶⡆⠄⡆⠄⡂⢀⢀⣀⢸⣿⣿⣷⣸⣿⡈⠁⢰⡆⢱⣦⠄⠄⠸⠗⣿⣿⡇⢸⢿⡯⣿⣿⣿⣿⣿⣿⣽⣿⡟⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠂⠄⠄⠄⠄⠄⠄⢀⢠⣤⣶⣾⣿⣇⢸⣿⣿⣿⣶⣶⣶⡆⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡆⠣⠄⠁⠈⠈⠉⢸⡏⣯⡽⡏⠙⣧⡄⠨⠅⡌⢹⣶⡦⠠⠄⠏⠉⠃⢸⢾⣷⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⠄⠘⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⡀⠄⠄⠄⠄⠠⡇⠸⠄⠸⣿⣿⣿⣿⠄⢸⣿⣿⣿⣿⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⠄⠄⠄⠄⠘⠃⠛⠛⣟⣣⣸⣇⠘⠃⡃⠄⠃⠄⠄⠄⠄⠄⠛⢛⢸⡟⣻⣿⣟⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣸⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⢻⣿⣿⣿⣧⡄⣿⣿⣿⣿⣿⣇⠸⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠄⠄⠄⠄⠄⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⢠⡤⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⠄⠄⡄⢸⢼⡿⢼⡿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⠄⠄⠄⠄⣀⣀⣀⣀⣀⣀⣀⣸⠄⠄⠄⠄⠄⠘⢻⣿⣿⣇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⡿⢿⣿⡇⢿⣿⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⡿⠿⢿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡀⢠⢸⣿⠿⠇⠄⠄⠄⢀⠄⠄⠄⠄⠃⠄⠄⠄⠄⠄⠃⠘⠛⢛⠘⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣧⣤⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠄⠄⠄⠄⠠⠄⠸⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠿⠇⠘⢻⠟⠛⠛⠛⠃⠄⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠘⠣⢠⡤⡿⢿⣿⣿⣿⣿⠄⠄⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⠛⢛⡛⠛⠃⠄⠄⠄⠄⣸⣿⢃⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⡤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⢀⢀⡀⣿⣿⡀⠄⠄⠄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⡀⠄⠄⠄⠄⠄⠄⠄⣃⣸⣿⣿⣿⡟⠄⠄⠄⠄⠄⠠⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣤⡤⠧⠤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣸⣧⣿⣿⣟⣛⢿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⢸⣾⡷⠸⢿⡿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠰⠾⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⠉⠉⠹⣹⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣆⢰⣶⣶⣾⣿⣿⣿⡿⠇⠄⠄⠄⠄⠄⠄⠄⠈⠁⠇⠸⠹⠿⢸⣷⣿⣿⣿⣿⢸⣿⣏⡁⠁⠄⠄⠄⢀⣈⡇⠄⠄⠄⠄⠄⠄⠄⣆⣸⣿⣿⣿⣿⡿⢿⢸⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠸⣿⣇⡆⠸⠄⠄⠄⠄⠄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡀⠁⠄⠄⢀⢀⣀⢈⡉⠉⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⠁⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣸⣿⣿⣿⠏⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠁⠄⠄⡁⢈⠈⠉⢿⡏⡇⠈⠄⠄⠄⠄⠄⠄⠄⠄⢸⡇⡇⠄⠄⠄⢰⣶⢶⡆⡿⢿⣿⣿⣿⣷⣁⣰⣾⣿⣿⣿⣿⣿⣿⣿",
                    "",
                },
                highlight = "DashboardHeader", -- Cpt integration my beloved
            },
            center = {
                items = {
                    {
                        icon = "  ",
                        text = "Open last session                     ",
                        shortcut = "s l",
                        action = "SessionManager load_session",
                    },
                    {
                        icon = "  ",
                        text = "Recently opened files                 ",
                        shortcut = "f h",
                        action = "Telescope oldfiles",
                    },
                    {
                        icon = "  ",
                        text = "Find file                             ",
                        shortcut = "f f",
                        action = "Telescope find_files find_command=rg,--hidden,--files",
                    },
                    {
                        icon = "  ",
                        text = "Find word                             ",
                        shortcut = "f a",
                        action = "Telescope live_grep",
                    },
                    {
                        icon = "  ",
                        text = "New file                              ",
                        shortcut = "c n",
                        action = "enew",
                    },
                    {
                        icon = "  ",
                        text = "File browser                          ",
                        shortcut = "f w",
                        action = "Telescope find_files",
                    },
                    {
                        icon = "  ",
                        text = "Change colorscheme                    ",
                        shortcut = "t c",
                        action = "Telescope colorscheme",
                    },
                },
                icon_highlight = "DashboardCenter",
                text_highlight = "DashboardCenter",
                shortcut_highlight = "DashboardShortcut",
                spacing = true,
            },
            footer = {
                lines = {
                    "",
                    "",
                    "Neovim started in " .. startup_time() .. " ms",
                    "Neovim loaded " .. #vim.tbl_keys(require("pckr.plugin").plugins) .. " plugins",
                },
                highlight = "DashboardFooter",
            },
        }

        require("ppebboard").setup(cfg)
    end,
}
