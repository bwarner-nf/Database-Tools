



    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Salesforce Accounts'
        , 'Implied response from the fact that this DUNS already has an account'
      )


    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Responed Campain Members'
        , 'DUNS numbers for campain members who have been marked as responed'
      )

    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Non-House-Status Leads'
        , 'Grab ALL Duns numbers from Non-house Leads when lead is inserted the lead status defaults to house?, until they respond'
      )

    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Marketing Scrub Leads'
        , 'Leads marked as Marketing Scrub'
      )

    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Out of Business Leads'
        , 'Leads marked as Out of Buisiness'
      )

    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Responder File Matched 1'
        , 'Old database cleaning project; We gave Ron a bunch OF responded files, and he appended these to supress from mail: FILE 1'
      )

    INSERT
      dbo.MailSuppressionSource
        (
            MailSuppressionSourceName
          , MailSuppressionSourceDesc
        )
    VALUES
      (
          'Responder File Matched 2'
        , 'Old database cleaning project; We gave Ron a bunch OF responded files, and he appended these to supress from mail: FILE 2'
      )




