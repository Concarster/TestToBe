workspace "TestToBe"

     architecture "x86"
     architecture "x64"

     startproject "Game"

     filter "system:windows"
		disablewarnings { "4996", "4251" }
                  
platforms {       -- Dropdown Solution Confg Platforms section in VS
    
     "Win32",
     "x64"
} 
    
configurations {   -- Dropdown Solution Configurations
     "Debug",
     "Release"  
}

outputdir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"]     = "Mods/GLFW/include"
IncludeDir["Glad"]     = "Mods/Glad/include"
IncludeDir["ImGui"]    = "Mods/imgui"
IncludeDir["glm"]      = "Mods/glm"
IncludeDir["SOIL2"]    = "Mods/SOIL2/incs"
IncludeDir["GSL"]      = "Mods/GSL/include"
IncludeDir["spdlog"]   = "Mods/spdlog/include"

group "Dependencies"

include "Mods/GLFW"
include "Mods/Glad"
include "Mods/imgui"
include "Mods/SOIL2"

 group ""

--[[ GLOBAL Precompiled Header   
pchheader "EPch.h"
pchsource "Engine/src/EPch.cpp"
]]


project "Engine" 
    location "Engine"
    kind "SharedLib"
    language "C++"

    pchheader "EPch.h"
    pchsource "Engine/src/EPch.cpp"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir    ("bint/" .. outputdir .. "/%{prj.name}")


    files {

        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",

    }

    includedirs {
        "%{prj.name}/src",
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}",
        "%{IncludeDir.boost}",
        "$(BOOST)",
    }

    libdirs { 
        "$(BOOST)/stage/lib" 
    }

    links { 
        "GLFW",
		"Glad",
		"ImGui",
        "SOIL2";
		"opengl32.lib"
	}

    filter"system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines {
             "TEST_ENGINE",
             "TEST_WINDOW",
             "TEST_BUILD_DLL",
             "GLFW_INCLUDE_NONE"
        }

        postbuildcommands {
            ("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Game/\"")
        }

        filter "configurations:Debug"
        buildoptions "/MDd"
        defines "TEST_DEBUG"
        symbols "On"

        filter "configurations:Release"
        buildoptions "/MD"
        defines "TEST_RELEASE"
        optimize "On"


-----------------------------------
-----     PROJECT # 1 BooErGame     -----
-----------------------------------

project "Game" 
    location "Game"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bint/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
    }

    includedirs {

        "Engine/src",
        "%{prj.name}/src",
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}",
        "$(BOOST)",
    }

    libdirs { 
        "$(BOOST)/stage/lib" 
    }
  
    links {
        "Engine",
		"opengl32.lib"
    }

    filter"system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines {
             "TEST_ENGINE",
             "TEST_WINDOW"
        }


        filter "configurations:Debug"
        buildoptions "/MDd"
        defines "TEST_DEBUG"
        symbols "On"

        filter "configurations:Release"
        buildoptions "/MD"
        defines "TEST_RELEASE"
        optimize "On"
