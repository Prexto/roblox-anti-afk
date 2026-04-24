# 🎮 Roblox Anti-AFK

Un script simple de **AutoHotkey** que evita que te saquen de Roblox por inactividad.

Roblox te desconecta después de **20 minutos** sin actividad. Este script salta automáticamente cada cierto intervalo para mantener tu personaje activo — ideal para farming, grinding, o simplemente estar AFK sin preocuparte.

---

## ⚙️ Cómo Funciona

El script envía un salto (tecla `Space`) al proceso de Roblox en intervalos regulares. Usa `SendEvent` con `keybd_event` API para compatibilidad con el anti-cheat de Roblox (Byfron), y mantiene la tecla presionada 150ms para asegurar que el juego detecte el input en cada frame.

**Resumen técnico:**
- Detecta la ventana de Roblox por nombre de proceso (`RobloxPlayerBeta.exe`)
- Activa la ventana con `WinActivateForce` y espera confirmación con `WinWaitActive`
- Envía `{Space down}` → espera 150ms → `{Space up}` para simular una pulsación real
- Intervalo configurable entre saltos

---

## 📦 Requisitos

- [AutoHotkey v1.1](https://www.autohotkey.com/) (no v2)
- Windows 10/11

---

## 🚀 Uso

1. Descarga e instala [AutoHotkey v1.1](https://www.autohotkey.com/)
2. Descarga o clona este repositorio
3. Haz doble clic en `anti_afk_roblox.ahk`
4. Abre Roblox y entra a tu juego
5. Déjalo corriendo — el script se encarga del resto

---

## 🖥️ Interfaz

El script incluye una ventana flotante personalizada (sin barra de título de Windows) con:

- **Estado actual** — verde = activo, rojo = pausado
- **Contador de saltos** — cuántas veces ha saltado
- **Detección de errores** — avisa si Roblox no está abierto
- **Botón X** para cerrar
- **Draggable** — arrastra desde el header para mover la ventana

---

## ⌨️ Controles

| Tecla | Acción |
|-------|--------|
| `F1`  | Pausar / Reanudar |
| `F2`  | Cerrar el script |

---

## 🔧 Configuración

Para cambiar el intervalo entre saltos, edita esta línea al inicio del archivo:

```ahk
SetTimer, DoJump, 3000   ; 3000ms = 3 segundos (modo test)
```

**Valores recomendados para uso real:**

| Valor | Intervalo |
|-------|-----------|
| `180000` | 3 minutos |
| `300000` | 5 minutos |
| `480000` | 8 minutos |
| `540000` | 9 minutos |

> ⚠️ No uses valores mayores a `600000` (10 minutos) — Roblox te sacará antes de que el script salte.

---

## 📝 Notas

- El script **activa la ventana de Roblox** cada vez que salta. Si estás usando la PC para otra cosa, Roblox tomará el foco momentáneamente
- Para uso nocturno/AFK prolongado, simplemente deja Roblox abierto y el script corriendo
- Funciona con el anti-cheat Byfron de Roblox

---

## 📄 Licencia

[The Unlicense](LICENSE) — dominio público. Haz lo que quieras con esto. Hecho por **Prexto**.
