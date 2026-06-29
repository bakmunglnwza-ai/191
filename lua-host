[package.json](https://github.com/user-attachments/files/29470439/package.json)
[README.md](https://github.com/user-attachments/files/29470764/README.md)
[eiei.lua.txt](https://github.com/user-attachments/files/29470746/eiei.lua.txt)
[Uploading README.md…]()
[server.js](https://github.com/user-attachments/files/29470441/server.js)
# วิธีใช้เซิร์ฟเวอร์ฝากโค้ด Lua

## โครงสร้างไฟล์
```
lua-host/
├── server.js          <- ตัวเซิร์ฟเวอร์
├── package.json        <- รายการ dependency
└── scripts/
    └── 191script/
        └── eiei.lua     <- ไฟล์โค้ดตัวอย่าง
```

ต้องการเพิ่มไฟล์ใหม่ ก็สร้างโฟลเดอร์ย่อยใน `scripts/` แล้ววางไฟล์ `.lua` ลงไป
เช่น `scripts/myfolder/myfile.lua` จะเข้าถึงได้ผ่าน path `/myfolder/myfile`

## รันทดสอบบนเครื่องตัวเอง (ต้องลง Node.js ก่อน)
```bash
cd lua-host
npm install
npm start
```
จะรันที่ `http://localhost:3000`
ทดสอบเปิด `http://localhost:3000/191script/eiei` ใน browser ควรเห็นโค้ด Lua

## เอาขึ้นเน็ตจริง (ฟรี) — แนะนำ Render.com
1. สมัครบัญชี https://render.com (ใช้ GitHub login ก็ได้)
2. เอาโฟลเดอร์ `lua-host` นี้ขึ้น GitHub repo ก่อน (สร้าง repo ใหม่ แล้ว push ไฟล์ทั้งหมดขึ้นไป)
3. ใน Render กด **New** → **Web Service** → เลือก repo ที่ push ไป
4. ตั้งค่า:
   - Build Command: `npm install`
   - Start Command: `npm start`
5. กด Deploy รอสักครู่ จะได้ URL แบบ `https://your-app-name.onrender.com`

## ใช้งานใน Roblox Studio command bar
```lua
loadstring(game:HttpGet("https://your-app-name.onrender.com/191script/eiei"))()
```
(ใช้ได้แค่ใน Studio command bar เท่านั้น ไม่ทำงานในเกมที่ publish แล้ว ตามที่คุยกันก่อนหน้า)

## ทางเลือกอื่นถ้าไม่อยากใช้ Render
- **Glitch.com** — อัปโหลดไฟล์ตรงในเว็บได้เลย ไม่ต้องผ่าน GitHub
- **Replit.com** — เขียนโค้ดในเว็บ แล้วกด Run ได้ URL ทันที (มี "Always On" แบบเสียเงินถ้าอยากให้ออนไลน์ตลอด)

## ข้อควรระวัง
- โฟลเดอร์ `scripts/` ทุกไฟล์เข้าถึงได้แบบ public ถ้าใครรู้ path ก็เปิดดูโค้ดได้ ไม่มีระบบ login/password ในตัวอย่างนี้
- ห้ามฝัง webhook URL, token, หรือข้อมูลลับอื่นๆไว้ในไฟล์ที่ฝากแบบนี้ เพราะใครก็เปิดดูได้เหมือนกับ GitHub public repo
