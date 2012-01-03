
C_DEFINES=$(C_DEFINES) -DNDIS_MINIPORT_DRIVER -DBINARY_COMPATIBLE=0
USER_C_FLAGS=$(USER_C_FLAGS) /nologo
MSC_WARNING_LEVEL=/W3 /WX

!if "$(DDK_TARGET_OS)"=="Win2K"
C_DEFINES=$(C_DEFINES) -DNDIS50_MINIPORT=1
DISABLE_WPP=1  
!elseif "$(DDK_TARGET_OS)"=="WinXP"
C_DEFINES=$(C_DEFINES) -DNDIS51_MINIPORT=1 
!elseif "$(DDK_TARGET_OS)"=="WinNET"
C_DEFINES=$(C_DEFINES) -DNDIS51_MINIPORT=1 
!elseif "$(DDK_TARGET_OS)"=="WinLH"
C_DEFINES=$(C_DEFINES) -DNDIS60_MINIPORT=1 
!elseif "$(DDK_TARGET_OS)"=="Win7"
C_DEFINES=$(C_DEFINES) -DNDIS620_MINIPORT=1
!else
!error DDK_TARGET_OS defined as "$(DDK_TARGET_OS)" (unsupported)
!endif

C_DEFINES=$(C_DEFINES) -DPARANDIS_MAJOR_DRIVER_VERSION=$(_MAJORVERSION_) -DPARANDIS_MINOR_DRIVER_VERSION=$(_MINORVERSION_)
RCOPTIONS=-D_MAJORVERSION_=$(_MAJORVERSION_) -D_MINORVERSION_=$(_MINORVERSION_) -D_NT_TARGET_MAJ=$(_NT_TARGET_MAJ) -D_NT_TARGET_MIN=$(_NT_TARGET_MIN)

#ENABLE_EVENT_TRACING=1

!IF "$(ENABLE_EVENT_TRACING)"=="1" && "$(DISABLE_WPP)"==""

C_DEFINES = $(C_DEFINES) -DWPP_EVENT_TRACING

RUN_WPP=$(SOURCES)\
        -km\
        -func:DPrintf(LEVEL,(MSG,...)) 
	

!ENDIF
