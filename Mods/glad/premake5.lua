project "Glad"
    kind "StaticLib"
    language "C"
    
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bint/" .. outputdir .. "/%{prj.name}")

	files {

        "include/glad/glad.h",
        "include/KHR/khrplatform.h",
        "src/glad.c"
    }

    includedirs {
         
         "include"
    
    }
    
	filter "system:windows"
        buildoptions { "-std=c17", "-lgdi32" }
        systemversion "latest"
        staticruntime "On"
        
        
    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"