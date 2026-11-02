# Restore Shaders Procedure (NVIDIA ComputeCache Cleaner)

Procedimiento 100% nativo ("vanilla") para Windows que vacía automáticamente el contenido de la caché de shaders de NVIDIA (`%APPDATA%\NVIDIA\ComputeCache`) cada vez que se inicia sesión en Windows.

## Características
- **Genérico para cualquier Windows**: Usa las variables de entorno nativas `%APPDATA%` (`C:\Users\<Usuario>\AppData\Roaming`) y `%LOCALAPPDATA%`, sin rutas fijas ligadas a un usuario concreto.
- **100% Vanilla (Sin dependencias)**: Escrito íntegramente en Batch nativo de Windows (`cmd.exe` y `reg.exe`), sin requerir PowerShell externo, permisos de Administrador ni componentes adicionales.
- **Independiente de la ubicación del repositorio**: El instalador copia el script ejecutable a `%LOCALAPPDATA%\RestoreShadersProcedure\` y registra su ejecución en `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`.

## Estructura de archivos
- `clean_compute_cache.bat`: Script que elimina todos los archivos y subcarpetas dentro de `%APPDATA%\NVIDIA\ComputeCache`. También se puede ejecutar manualmente en cualquier momento.
- `install.bat`: Copia el limpiador en `%LOCALAPPDATA%\RestoreShadersProcedure`, crea la entrada de arranque en el registro del usuario actual (`HKCU\...\Run`) y ejecuta una primera limpieza de prueba.
- `uninstall.bat`: Elimina la entrada de arranque del registro y borra la carpeta de instalación en `%LOCALAPPDATA%`.

## Uso

### Instalar
Haz doble clic en **`install.bat`** (o ejecútalo desde `cmd`).

### Desinstalar
Haz doble clic en **`uninstall.bat`** (o ejecútalo desde `cmd`).
