module ApplicationHelper
    # a patch for a rails bug with singular resources
    def users_path(*args)
        user_path(*args)
    end
end
