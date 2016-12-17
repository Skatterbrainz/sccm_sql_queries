SELECT        TOP (1000) dbo.v_GS_SERVER_FEATURE.ResourceID, dbo.v_GS_SERVER_FEATURE.GroupID, dbo.v_GS_SERVER_FEATURE.RevisionID, dbo.v_GS_SERVER_FEATURE.AgentID, 
                         dbo.v_GS_SERVER_FEATURE.TimeStamp, dbo.v_GS_SERVER_FEATURE.ID0, dbo.v_GS_SERVER_FEATURE.Name0, dbo.v_GS_SERVER_FEATURE.ParentID0, dbo.v_R_System.Name0 AS Expr1
FROM            dbo.v_GS_SERVER_FEATURE INNER JOIN
                         dbo.v_R_System ON dbo.v_GS_SERVER_FEATURE.ResourceID = dbo.v_R_System.ResourceID
WHERE        (dbo.v_GS_SERVER_FEATURE.Name0 IN ('ASP', 'Windows Internal Database', 'Web Server'))