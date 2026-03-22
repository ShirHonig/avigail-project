-- 5. Select username and password for non-admin users from "Ness Ziona"
-- ❗FIXED: City name should be consistent — use 'Ness Ziona' instead of 'Nes Tziona'
SELECT Username, Password
FROM tblUsers
WHERE City = 'Ness Ziona' AND Admin = 0;