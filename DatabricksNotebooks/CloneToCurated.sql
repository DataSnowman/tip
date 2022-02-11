-- Databricks notebook source
-- MAGIC %python
-- MAGIC adlsAccountName = "synapsetiphackathon"
-- MAGIC sourceAdlsContainerName = "commonzone"
-- MAGIC sinkAdlsContainerName = "commonzone"
-- MAGIC sourceAdlsFolderName = "enricheddata/tiphackdelta/call_center/"
-- MAGIC sinkAdlsFolderName = "curateddata/tiphackdelta/call_center/"

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.conf.set(
-- MAGIC     "fs.azure.account.key." + adlsAccountName + ".dfs.core.windows.net",
-- MAGIC     dbutils.secrets.get(scope="autoloaderphotonscope",key="Tip-adls2-secret"))

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.ls("abfss://" + sourceAdlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/")

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.ls("abfss://" + sinkAdlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/")

-- COMMAND ----------

-- MAGIC %python
-- MAGIC SubscriptionID = dbutils.secrets.get("autoloaderphotonscope","SubscriptionID")
-- MAGIC DirectoryID = dbutils.secrets.get("autoloaderphotonscope","DirectoryID")
-- MAGIC ServicePrincipalAppID = dbutils.secrets.get("autoloaderphotonscope","ServicePrincipalAppID")
-- MAGIC ServicePrincipalSecret = dbutils.secrets.get("autoloaderphotonscope","autoloaderphotonappsecret")
-- MAGIC ResourceGroup = dbutils.secrets.get("autoloaderphotonscope","TipResourceGroup")
-- MAGIC BlobConnectionKey = dbutils.secrets.get("autoloaderphotonscope","Tip-adls2-secret")

-- COMMAND ----------

-- MAGIC %python
-- MAGIC configs = {"fs.azure.account.auth.type": "OAuth",
-- MAGIC            "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
-- MAGIC            "fs.azure.account.oauth2.client.id": ServicePrincipalAppID,
-- MAGIC            "fs.azure.account.oauth2.client.secret": ServicePrincipalSecret,
-- MAGIC            "fs.azure.account.oauth2.client.endpoint": "https://login.microsoftonline.com/"+DirectoryID+"/oauth2/token"}

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.unmount("/mnt/source")
-- MAGIC dbutils.fs.unmount("/mnt/sink") 

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.mount(
-- MAGIC   source = "abfss://"+sourceAdlsContainerName+"@"+adlsAccountName+".dfs.core.windows.net/",
-- MAGIC   mount_point = "/mnt/source",
-- MAGIC   extra_configs = configs)
-- MAGIC 
-- MAGIC 
-- MAGIC dbutils.fs.mount(
-- MAGIC   source = "abfss://"+sinkAdlsContainerName+"@"+adlsAccountName+".dfs.core.windows.net/",
-- MAGIC   mount_point = "/mnt/sink",
-- MAGIC   extra_configs = configs)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC clonesink = "/mnt/sink/"+sinkAdlsFolderName
-- MAGIC 
-- MAGIC print (clonesink)
-- MAGIC 
-- MAGIC clonesource = "/mnt/source/"+sourceAdlsFolderName
-- MAGIC print (clonesource)

-- COMMAND ----------

CREATE TABLE delta.`/mnt/sink/curateddata/tiphackdelta/warehouse/` CLONE delta.`/mnt/source/enricheddata/tiphackdelta/warehouse/`
