wsl_action
    id:"variable"
    description:"Test the value of a WSL variable against another value."

    action: (cfg) ->
        name = cfg.name
        unless name then error "no name key in argument"

        var = wesmere.get_variable(name)

        if equals = cfg.equals
            return var == equals

        if not_equals = cfg.not_equals
            return var != not_equals

        if greater_than = cfg.greater_than
            return var > greater_than

        if greater_than_equal_to = cfg.greater_than_equal_to
            return var => greater_than_equal_to

        if less_than = cfg.less_than
            return var < less_than

        if less_than_equal_to = cfg.less_than_equal_to
            return var <= less_than_equal_to


    scheme:
        name:
            description:"The name of the variable to test."

            -- <comparison>: One of the following keys must be used to compare the value of the named variable, represented as $name below, against another value:
-- contains: $name contains this string value.
-- equals: $name is equal (string wise) to this value.
-- not_equals: $name is not equal (string wise) to this value.
-- numerical_equals: $name is equal (numerically) to this value.
-- numerical_not_equals: $name is not equal (numerically) to this value. *
-- * Using equals is faster. The point of numerical_equals and boolean_equals is not performance, it's representation. For instance, "1" and "1.0" are not equal as strings but they are equal as numbers; and "yes" and "true" are not equal as strings but they are equal as booleans. (This also explains why equals is faster: it is a straightforward comparison that doesn't try to understand what you have written.)
-- greater_than: $name is greater than this value.
-- greater_than_equal_to: $name is greater than or equal to this value.
-- less_than: $name is less than this value.
-- less_than_equal_to: $name is less than or equal to this value.
-- boolean_equals: $name has an equivalent boolean value. *
-- boolean_not_equals: $name does not have an equivalent boolean value. *]]
