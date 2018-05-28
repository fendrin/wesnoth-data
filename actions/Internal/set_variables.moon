wsl_action
    id: "set_variables"
    description: "Manipulates a WSL array or container"

    action: (cfg, kernel) ->

    scheme:
        name:
            description: "the name of the array or container to manipulate"
        mode:
            description: "one of the following values:
replace: will clean the array name and replace it with given data
append: will append given data to the current array
merge: will merge in the given data into name
insert: will insert the given data at the index specified in the name attribute, such as name=my_array[1]. The default index is zero, which will insert to the front of the array. Note: if an invalid index is used, empty containers will be created before the insertion is performed. In other words, do not attempt to insert at an index greater than (or equal to) the array's current length. This limitation may be removed in future versions."

        to_variable:
            description: "data will be set to the given array"

        value:
            description: "the WSL inside the [value] tags will be stored in data, variables will be interpolated directly, use $| in order to escape the $ sign, you can store arrays of WSL by supplying multiple [value] tags. (See Example)"

        literal:
            description: "same as [value], but variables will not be substituted, [literal] and [value] can not be used in the same [set_variables] tag, i.e. you can not create arrays by piling a mix of [value] and [literal] tags"

        split:
            description: "splits a textual list into an array which will then be set to data"

            scheme:
                list:
                    description: "textual list to split"
                key:
                    description: "the key of each array element(array[$i].foo) in which the strings are stored"
                separator:
                    description: "separator to separate the elements"
                remove_empty:
                    description: "whether to ignore empty elements"



-- (Version 1.13.2 and later only) You can now mix [value], [literal], and [split] in the same [set_variables] tag. They will be processed in order of appearance. Multiple instances of [split] are also supported now.
