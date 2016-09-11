module EpitechApi
  # TODO: Mark doc
  class Mark
    @title          : String
    @date           : Time
    @correcteur     : String
    @final_note     : Float64
    @comment        : String
    @schoolyear     : Int32     = 0
    @codemodule     : String    = ""
    @codeinstance   : String    = ""
    @codeacti       : String    = ""

    def initialize(@title, @date, @final_note, @comment = "", @correcteur = "")
    end
  end
end
