CREATE TABLE Organization (
    orgId   CHAR (10)    PRIMARY KEY
                         NOT NULL,
    orgName VARCHAR (30),
    orgLink VARCHAR (40) 
);

CREATE TABLE Job (
    jobId           CHAR (10)      PRIMARY KEY
                                   NOT NULL,
    orgId           CHAR (10)      REFERENCES Organization (orgId) ON DELETE CASCADE
                                                                   ON UPDATE CASCADE
                                   NOT NULL,
    jobTitle        VARCHAR (30),
    deadline        DATE,
    jobDesc         VARCHAR (1000),
    function        VARCHAR (30),
    industry        VARCHAR (30),
    jobType         VARCHAR (30),
    location        VARCHAR (30),
    reqWorkEx       INTEGER,
    interviewFormat VARCHAR (50),
    openFrom        DATE,
    workAuthReq     VARCHAR (30),
    appMethod       VARCHAR (50) 
);

CREATE TABLE Candidate (
    candidateEmail CHAR (40)     PRIMARY KEY
                                 NOT NULL,
    password       CHAR (40)     NOT NULL,
    fName          VARCHAR (20),
    mName          VARCHAR (20),
    lName          VARCHAR (20),
    dob            DATE,
    address        VARCHAR (30),
    gpa            FLOAT (2, 1),
    major          VARCHAR (20),
    gender         CHAR (1),
    description    VARCHAR (200),
    workAuth       VARCHAR (30),
    workExp        VARCHAR (200) 
);

CREATE TABLE Skill (
    skillId   CHAR (10)    PRIMARY KEY
                           NOT NULL,
    skillName VARCHAR (30) 
);

CREATE TABLE Apply (
    jobId          CHAR (10)     REFERENCES Job (jobId) ON DELETE CASCADE
                                                        ON UPDATE CASCADE
                                 NOT NULL,
    candidateEmail CHAR (40)     REFERENCES Candidate (candidateEmail) ON DELETE CASCADE
                                                                       ON UPDATE CASCADE
                                 NOT NULL,
    applyDate      DATE,
    appDescription VARCHAR (200),
    PRIMARY KEY    (jobId, candidateEmail)
);

CREATE TABLE Has (
    candidateEmail CHAR (40) REFERENCES Candidate (candidateEmail) ON DELETE CASCADE
                                                                   ON UPDATE CASCADE
                             NOT NULL,
    skillId        CHAR (10) REFERENCES Skill (skillId) ON DELETE CASCADE
                                                        ON UPDATE CASCADE
                             NOT NULL,
    proficiency    INTEGER,
    PRIMARY KEY    (candidateEmail, skillId)
);
