-------------------------------------------------------------------------------------------------
--ENode used tables

CREATE TABLE [dbo].[Command] (
    [Sequence]                BIGINT IDENTITY (1, 1) NOT NULL,
    [CommandId]               NVARCHAR (36)          NOT NULL,
    [AggregateRootId]         NVARCHAR (36)          NULL,
    [MessagePayload]          NVARCHAR (MAX)         NULL,
    [MessageTypeCode]         INT                    NOT NULL,
    [CreatedOn]               DATETIME               NOT NULL,
    CONSTRAINT [PK_Command] PRIMARY KEY CLUSTERED ([CommandId] ASC)
)
GO
CREATE TABLE [dbo].[EventStream] (
    [Sequence]                BIGINT IDENTITY (1, 1) NOT NULL,
    [AggregateRootTypeCode]   INT                    NOT NULL,
    [AggregateRootId]         NVARCHAR (36)          NOT NULL,
    [Version]                 INT                    NOT NULL,
    [CommandId]               NVARCHAR (36)          NOT NULL,
    [CreatedOn]               DATETIME               NOT NULL,
    [Events]                  NVARCHAR (MAX)         NOT NULL,
    CONSTRAINT [PK_EventStream] PRIMARY KEY CLUSTERED ([AggregateRootId] ASC, [Version] ASC)
)
GO
CREATE UNIQUE INDEX [IX_EventStream_AggId_CommandId] ON [dbo].[EventStream] ([AggregateRootId], [CommandId])
GO
CREATE TABLE [dbo].[SequenceMessagePublishedVersion] (
    [Sequence]                BIGINT IDENTITY (1, 1) NOT NULL,
    [ProcessorName]           NVARCHAR (128)         NOT NULL,
    [AggregateRootTypeCode]   INT                    NOT NULL,
    [AggregateRootId]         NVARCHAR (36)          NOT NULL,
    [PublishedVersion]        INT                    NOT NULL,
    [CreatedOn]               DATETIME               NOT NULL,
    CONSTRAINT [PK_SequenceMessagePublishedVersion] PRIMARY KEY CLUSTERED ([ProcessorName] ASC, [AggregateRootId] ASC, [PublishedVersion] ASC)
)
GO
CREATE TABLE [dbo].[MessageHandleRecord] (
    [Sequence]                  BIGINT IDENTITY (1, 1) NOT NULL,
    [MessageId]                 NVARCHAR (36)          NOT NULL,
    [HandlerTypeCode]           INT                    NOT NULL,
    [MessageTypeCode]           INT                    NOT NULL,
    [AggregateRootTypeCode]     INT                    NOT NULL,
    [AggregateRootId]           NVARCHAR (36)          NULL,
    [Version]                   INT                    NULL,
    [CreatedOn]                 DATETIME               NOT NULL,
    CONSTRAINT [PK_MessageHandleRecord] PRIMARY KEY CLUSTERED ([MessageId] ASC, [HandlerTypeCode] ASC)
)
GO
CREATE TABLE [dbo].[TwoMessageHandleRecord] (
    [Sequence]                  BIGINT IDENTITY (1, 1) NOT NULL,
    [MessageId1]                NVARCHAR (36)          NOT NULL,
    [MessageId2]                NVARCHAR (36)          NOT NULL,
    [HandlerTypeCode]           INT                    NOT NULL,
    [Message1TypeCode]          INT                    NOT NULL,
    [Message2TypeCode]          INT                    NOT NULL,
    [AggregateRootTypeCode]     INT                    NOT NULL,
    [AggregateRootId]           NVARCHAR (36)          NULL,
    [Version]                   INT                    NULL,
    [CreatedOn]                 DATETIME               NOT NULL,
    CONSTRAINT [PK_TwoMessageHandleRecord] PRIMARY KEY CLUSTERED ([MessageId1] ASC, [MessageId2] ASC, [HandlerTypeCode] ASC)
)
GO
CREATE TABLE [dbo].[ThreeMessageHandleRecord] (
    [Sequence]                  BIGINT IDENTITY (1, 1) NOT NULL,
    [MessageId1]                NVARCHAR (36)          NOT NULL,
    [MessageId2]                NVARCHAR (36)          NOT NULL,
    [MessageId3]                NVARCHAR (36)          NOT NULL,
    [HandlerTypeCode]           INT                    NOT NULL,
    [Message1TypeCode]          INT                    NOT NULL,
    [Message2TypeCode]          INT                    NOT NULL,
    [Message3TypeCode]          INT                    NOT NULL,
    [AggregateRootTypeCode]     INT                    NOT NULL,
    [AggregateRootId]           NVARCHAR (36)          NULL,
    [Version]                   INT                    NULL,
    [CreatedOn]                 DATETIME               NOT NULL,
    CONSTRAINT [PK_ThreeMessageHandleRecord] PRIMARY KEY CLUSTERED ([MessageId1] ASC, [MessageId2] ASC, [MessageId3] ASC, [HandlerTypeCode] ASC)
)
GO
CREATE TABLE [dbo].[Snapshot] (
    [Sequence]               BIGINT IDENTITY (1, 1)  NOT NULL,
    [AggregateRootTypeCode]  INT                     NOT NULL,
    [AggregateRootId]        NVARCHAR (36)           NOT NULL,
    [Version]                INT                     NOT NULL,
    [Payload]                VARBINARY (MAX)         NOT NULL,
    [CreatedOn]              DATETIME                NOT NULL,
    CONSTRAINT [PK_Snapshot] PRIMARY KEY CLUSTERED ([AggregateRootId] ASC, [Version] ASC)
)
GO
CREATE TABLE [dbo].[LockKey] (
    [Name]                   NVARCHAR (128)          NOT NULL,
    CONSTRAINT [PK_LockKey] PRIMARY KEY CLUSTERED ([Name] ASC)
)
GO


-------------------------------------------------------------------------------------------------
--Note sample tables
CREATE TABLE [dbo].[Note](
    [Sequence]      BIGINT IDENTITY(1,1) NOT NULL,
    [Id]            NVARCHAR(32)         NOT NULL,
    [Title]         NVARCHAR(128)        NOT NULL,
    [CreatedOn]     DATETIME             NOT NULL,
    [UpdatedOn]     DATETIME             NOT NULL,
    [Version]       BIGINT               NOT NULL,
    [EventSequence] INT                  NOT NULL,
 CONSTRAINT [PK_Note] PRIMARY KEY CLUSTERED 
(
    [Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO