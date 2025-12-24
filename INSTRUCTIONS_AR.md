# تعليمات تشغيل نظام الأندرويد باستخدام Tailscale

بالتأكيد، Tailscale خيار أفضل وأكثر استقراراً ويعمل كشبكة خاصة افتراضية (VPN).

## الخطوة 1: تجهيز Tailscale
1. اذهب إلى [Tailscale Settings > Keys](https://login.tailscale.com/admin/settings/keys).
2. اضغط على **Generate OAuth Client**.
3. في خانة "Description" اكتب أي اسم (مثلاً `github-action`).
4. في خانة "Tags"، اختر `tag:ci` (يجب عليك إنشاء هذا الـ Tag أولاً إذا لم يكن موجوداً من قسم Access Controls، أو يمكنك استخدام `Create Auth Key` العادي بدلاً من OAuth للأسهل).

**الطريقة الأسهل (Auth Key):**
1. اذهب إلى **Settings > Keys** واضغط **Generate Auth Key**.
2. فعّل خيار **Reusable** (مهم جداً ليعمل أكثر من مرة).
3. فعّل خيار **Ephemeral** (لكي يتم حذف الجهاز تلقائياً بعد انتهاء الجلسة).
4. انسخ الكود (يبدأ بـ `tskey-auth-...`).

## الخطوة 2: إضافة السر في GitHub
1. في مستودع GitHub الخاص بك.
2. اذهب إلى `Settings` -> `Secrets and variables` -> `Actions`.
3. احذف `NGROK_AUTH_TOKEN` إذا كان موجوداً.
4. أضف سراً جديداً باسم `TS_OAUTH_SECRET` (أو عدل الملف ليستخدم `TS_AUTHKEY` إذا اخترت الطريقة الأسهل).
   *سنستخدم الطريقة الأسهل (Auth Key) في الشرح لسرعتها:*
   - اسم السر: `TAILSCALE_AUTHKEY`
   - القيمة: مفتاح `tskey-auth-...` الذي نسخته.

*(ملاحظة: لقد قمت بتحديث ملف Workflow ليدعم الطريقة الأسهل وهي Auth Key مباشرة)*.

## الخطوة 3: التشغيل والاتصال
1. شغل الـ Workflow من تبويب Actions.
2. بمجرد أن يعمل، سيظهر جهاز جديد في لوحة تحكم Tailscale الخاصة بك (Machines) باسم `github-runner-...`.
3. انسخ الـ **IP Address** الخاص به (سيبدأ غالباً بـ `100.x.x.x`).
4. تأكد أن جهازك الكمبيوتر أيضاً متصل بـ Tailscale.
5. افتح ملف `connect_to_android.bat` وضع فيه الـ IP.

## ميزة Tailscale
الآن اتصالك مشفر بالكامل ولا يمر عبر سيرفرات عامة مثل Ngrok، والسرعة ستكون أفضل بكثير (Direct Connection).
