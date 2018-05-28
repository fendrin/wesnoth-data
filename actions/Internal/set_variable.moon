
wsl_action

    id: "set_variable"
    description: [[The [set_variable] function is used to create and manipulate WSL variables. The VARIABLE function is a quick syntactic shortcut for simple variable creation and the VARIABLE_OP function is a quick syntactic shortcut for performing simple mathematical operations on variables.]]

    action: (cfg) ->
        -- assert(cfg.name, "WSLAction set_variable: Missing 'name' key in argument")

        -- local var
        -- if value = cfg.value
        --     var = value
        -- else
        --     var = wesmere.get_variable(cfg.name)


        -- game_data *gameinfo = resources::gamedata;
        name = cfg.name
        to_variable = cfg.to_variable
        local var

        try
            do: ->
                unless name
                    error "trying to set a variable with an empty name:\n" -- << cfg.get_config().debug();
                    return


                -- config::attribute_value literal = cfg.get_config()["literal"]; // no $var substitution
                -- if (!literal.blank()) {
                --     var = literal;
                -- }

                if value = cfg.value
                    var = value
                else  var = wesmere.get_variable(name)


                -- config::attribute_value value = cfg["value"];
                -- if (!value.blank()) {
                --     var = value;
                -- }

                -- if(to_variable.empty() == false) {
                --     var = gameinfo->get_variable_access_read(to_variable).as_scalar();
                -- }
                --if to_variable = cfg.to_variable
                --    var =

                if add = cfg["add"]
                    var += add

                if sub = cfg["sub"]
                    var -= sub

                if multiply = cfg["multiply"]
                    var *= multiply

                if divide = cfg["divide"]
                    if divide == 0
                        error "division by zero on variable " .. name
                        return
                    var /= divide

                if modulo = cfg["modulo"]
                    if modulo == 0
                        error "division by zero on variable " .. name
                        return
                    var %= modulo


--         config::attribute_value round_val = cfg["round"];
--         if (!round_val.empty()) {
--             double value = var.to_double();
--             if (round_val == "ceil") {
--                 var = int(std::ceil(value));
--             } else if (round_val == "floor") {
--                 var = int(std::floor(value));
--             } else {
--                 // We assume the value is an integer.
--                 // Any non-numerical values will be interpreted as 0
--                 // Which is probably what was intended anyway
--                 int decimals = round_val.to_int();
--                 value *= std::pow(10.0, decimals); //add $decimals zeroes
--                 value = round_portable(value); // round() isn't implemented everywhere
--                 value *= std::pow(10.0, -decimals); //and remove them
--                 var = value;
--             }
--         }

--         config::attribute_value ipart = cfg["ipart"];
--         if (!ipart.empty()) {
--             double result;
--             std::modf(ipart.to_double(), &result);
--             var = int(result);
--         }

--         config::attribute_value fpart = cfg["fpart"];
--         if (!fpart.empty()) {
--             double ignore;
--             var = std::modf(fpart.to_double(), &ignore);
--         }

--         config::attribute_value string_length_target = cfg["string_length"];
--         if (!string_length_target.blank()) {
--             var = int(string_length_target.str().size());
--         }

--         // Note: maybe we add more options later, eg. strftime formatting.
--         // For now make the stamp mandatory.
--         const std::string time = cfg["time"];
--         if(time == "stamp") {
--             var = int(SDL_GetTicks());
--         }

--         // Random generation works as follows:
--         // rand=[comma delimited list]
--         // Each element in the list will be considered a separate choice,
--         // unless it contains "..". In this case, it must be a numerical
--         // range (i.e. -1..-10, 0..100, -10..10, etc).
--         const std::string rand = cfg["rand"];

--         // The new random generator, the logic is a copy paste of the old random.
--         if(rand.empty() == false) {
--             assert(gameinfo);

--             // A default value in case something goes really wrong.
--             var = "";

--             std::string word;
--             std::vector<std::string> words;
--             std::vector<std::pair<long,long> > ranges;
--             long num_choices = 0;
--             std::string::size_type pos = 0, pos2 = std::string::npos;
--             std::stringstream ss(std::stringstream::in|std::stringstream::out);
--             while (pos2 != rand.length()) {
--                 pos = pos2+1;
--                 pos2 = rand.find(",", pos);

--                 if (pos2 == std::string::npos)
--                     pos2 = rand.length();

--                 word = rand.substr(pos, pos2-pos);
--                 words.push_back(word);
--                 std::string::size_type tmp = word.find("..");


--                 if (tmp == std::string::npos) {
--                     // Treat this element as a string
--                     ranges.push_back(std::pair<long, long>(0,0));
--                     num_choices += 1;
--                 }
--                 else {
--                     // Treat as a numerical range
--                     const std::string first = word.substr(0, tmp);
--                     const std::string second = word.substr(tmp+2,
--                         rand.length());

--                     long low, high;
--                     ss << first + " " + second;
--                     if ( !(ss >> low)  ||  !(ss >> high) ) {
--                         ERR_NG << "Malformed range: rand = \"" << rand << "\"" << std::endl;
--                         // Treat this element as a string?
--                         ranges.push_back(std::pair<long, long>(0,0));
--                         num_choices += 1;
--                     }
--                     else {
--                         if (low > high) {
--                             std::swap(low, high);
--                         }
--                         ranges.push_back(std::pair<long, long>(low,high));
--                         num_choices += (high - low) + 1;

--                         // Make 0..0 ranges work
--                         if (high == 0 && low == 0) {
--                             words.pop_back();
--                             words.push_back("0");
--                         }
--                     }
--                     ss.clear();
--                 }
--             }

--             assert(num_choices > 0);
--             // On most plattforms long can never hold a bigger value than a uint32_t, but there are exceptions where long is 64 bit.
--             if(static_cast<unsigned long>(num_choices) > std::numeric_limits<uint32_t>::max()) {
--                 WRN_NG << "Requested random number with an upper bound of "
--                     << num_choices
--                     << " however the maximum number generated will be "
--                     << std::numeric_limits<uint32_t>::max()
--                     << ".\n";
--             }
--             uint32_t choice = random_new::generator->next_random() % num_choices;
--             uint32_t tmp = 0;
--             for(size_t i = 0; i < ranges.size(); ++i) {
--                 tmp += (ranges[i].second - ranges[i].first) + 1;
--                 if (tmp > choice) {
--                     if (ranges[i].first == 0 && ranges[i].second == 0) {
--                         var = words[i];
--                     }
--                     else {
--                         var = (ranges[i].second - (tmp - choice)) + 1;
--                     }
--                     break;
--                 }
--             }
--         }


--         const vconfig::child_list join_elements = cfg.get_children("join");
--         if(!join_elements.empty())
--         {
--             const vconfig & join_element = join_elements.front();

--             std::string array_name=join_element["variable"];
--             std::string separator=join_element["separator"];
--             std::string key_name=join_element["key"];

--             if(key_name.empty())
--             {
--                 key_name="value";
--             }

--             bool remove_empty = join_element["remove_empty"].to_bool();

--             std::string joined_string;



--             variable_access_const vi = resources::gamedata->get_variable_access_read(array_name);
--             bool first = true;
--             BOOST_FOREACH(const config &cfg, vi.as_array())
--             {
--                 std::string current_string = cfg[key_name];
--                 if (remove_empty && current_string.empty()) continue;
--                 if (first) first = false;
--                 else joined_string += separator;
--                 joined_string += current_string;
--             }

--             var = joined_string;
--         }
--     }
            catch: (err) ->
                error "Found invalid variablename in \n[set_variable] " .. err -- .. cfg.get_config().debug() << "[/set_variable]\n where name = " << name << " to_variable = " << to_variable << "\n";

            finally: ->
                wesmere.set_variable(name, var)




















    scheme:
        name:
            description: "the name of the variable to manipulate"
            type: "string"
        value:
            description: "set the variable to the given value (can be numeric or string). Use literal for no substitution. (see VariablesWSL)"
        literal:
            description: "set the variable to the given value (can be numeric or string). This does not interpret any dollar signs."
        to_variable:
            description: "set the variable to the value of the given variable, e.g. 'to_variable=temp' would be equivalent to 'value=$temp'."
        add:
            description: "add the given amount to the variable."
        sub:
            description: "subtract the given amount from the variable."
        multiply:
            description: "multiply the variable by the given number. The result is a float.
To negate a number, multiply by -1. If you negate 0, the result is a floating-point negative zero -0. To display -0 as 0, use a second tag with add=0; it will flip -0 to 0 but not affect other numbers."
        divide:
            description: "divide the variable by the given number. The result is a float. Wesmere 1.9 and later no longer uses integer division. Use a second tag with round=floor if you relied on this."
        modulo:
            description: "returns the remainder of a division."
        rand:
            description: [[the variable will be randomly set.
You may provide a comma separated list of possibilities, e.g. 'rand:{"Bob","Bill","Bella"}'.
You may provide a range of numbers (integers), e.g. 'rand:"3..5"'.
You may combine these, e.g. 'rand:{100,"1..9"}', in which case there would be 1/10th chance of getting 100, just like for each of 1 to 9. If a number or item is repeated, it is sampled more frequently as appropriate. See MultiplayerContent for more info on the MP case.
Using rand= will automatically result in the current action being non undoable. Ignoring possible [allow_undo].
time=stamp: Retrieves a timestamp in milliseconds since wesmere was started, can be used as timing aid. Don't try to use this as random value in MP since it will cause an OOS.
string_length: Retrieves the length in characters of the string passed as this attribute's value; such string is parsed and variable substitution applied automatically (see VariablesWSL for details).]]

        join:
            description: "joins an array of strings to create a textual list"

            scheme:
                variable: "name of the array"
                key: "the key of each array element(array[$i].foo) in which the strings are stored"
                separator: "separator to connect the elements"
                remove_empty: "whether to ignore empty elements"
                ipart: "Assigns the integer part (the part to the left of the decimal point) of the referenced variable."
                fpart: "Assigns the decimal part (the part to the right of the decimal point) of the referenced variable."
                round: "Rounds the variable to the specified number of digits of precision. Negative precision works as expected (rounding 19517 to -2 = 19500). Special values:
round=ceil: Rounds upward to the nearest integer.
round=floor: Rounds down to the nearest integer."
