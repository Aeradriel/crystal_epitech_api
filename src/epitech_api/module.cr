module EpitechApi
  # TODO: Module doc
  class Module
    @codemodule       : String  = ""
    @codeinstance     : String  = ""
    @title            : String  = ""
    @credits          : Int32   = 0
    @scolaryear       : String  = ""
    @id_user_history  : String  = ""
    @date_ins         : Time    = Time.now
    @cycle            : String  = ""
    @grade            : String  = ""
    @barrage          : Bool    = false

    def initialize(@codemodule, @codeinstance, @title, @credits)
    end

    # Getter for @modules
    def title
      @title
    end
  end
end
