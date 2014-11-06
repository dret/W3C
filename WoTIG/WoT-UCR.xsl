<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xsd" version="2.0">
    <xsl:output method="xhtml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html>&#xa;</xsl:text>
        <html>
            <head>
                <title>Use Cases and Requirements for the Web of Things</title>
                <meta charset="utf-8"/>
                    <script src="http://www.w3.org/Tools/respec/respec-w3c-common" async="async" class="remove"></script>
                    <script class="remove">
                        var respecConfig = {
                        specStatus: "unofficial",
                        shortName:  "WoT-UCR",
                        editors: [
                        {   name:       "Johannes Hund",
                        company:    "Siemens",
                        companyURL: "http://www.siemens.com/" },
                        {   name:       "Erik Wilde",
                        url:        "http://dret.net/netdret/",
                        company:    "Siemens",
                        companyURL: "http://www.siemens.com/" }
                        ],
                        };
                    </script>
            </head>
            <body>
                <section id="abstract">
                    <p>This document describes Use Cases and Requirements for the Web of Things.</p>
                </section>
                <section id="use-cases">
                    <h2>Use Cases</h2>
                    <xsl:apply-templates select="/ucr/usecase"/>
                </section>
                <section id="requirements">
                    <h2>Requirements</h2>
                    <xsl:apply-templates select="/ucr/req"/>
                </section>
                <section id="technologies">
                    <h2>Technologies</h2>
                    <xsl:apply-templates select="/ucr/tech"/>
                </section>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="usecase">
        <div id="{@id}">
            <xsl:apply-templates select="title, p, ul">
                <xsl:with-param name="position" select="position()"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    <xsl:template match="req">
        <xsl:variable name="reqid" select="@id"/>
        <div id="{$reqid}">
            <xsl:apply-templates select="title, p">
                <xsl:with-param name="position" select="position()"/>
            </xsl:apply-templates>
            <dl>
                <dt><b>Motivated by <xsl:value-of select="count(/ucr/usecase[.//li[@reqref eq $reqid]])"/> Use Cases: </b></dt>
                <dd>
                    <ul>
                        <xsl:for-each select="/ucr/usecase//li[@reqref eq $reqid]">
                            <li>
                                <em>
                                    <a href="#{../../@id}" title="Go to complete Use Case">
                                        <xsl:value-of select="concat(../../title, ': ')"/>
                                    </a>
                                </em>
                                <a href="#{concat(../../@id, '-', $reqid)}" title="Go to Atomic Use Case">
                                    <xsl:apply-templates select="node()"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </dd>
                <dt><b>Covered by <xsl:value-of select="count(/ucr/tech[.//li[@reqref eq $reqid]])"/> Technologies: </b></dt>
                <dd>
                    <ul>
                        <xsl:for-each select="/ucr/tech//li[@reqref eq $reqid]">
                            <li>
                                <em>
                                    <a href="#{../../@id}" title="Go to Technology Description">
                                        <xsl:value-of select="concat(../../title, ': ')"/>
                                    </a>
                                </em>
                                <a href="#{concat(../../@id, '-', $reqid)}" title="Go to Technology Feature Description">
                                    <xsl:apply-templates select="node()"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </dd>
            </dl>
        </div>
    </xsl:template>
    <xsl:template match="tech">
        <div id="{@id}">
            <xsl:apply-templates select="title, p, ul">
                <xsl:with-param name="position" select="position()"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    <xsl:template match="title">
        <xsl:param name="position"/>
        <h4>
            <xsl:if test="exists(../@author)">
                <xsl:attribute name="title" select="concat('Authored by: ', ../@author)"/>
            </xsl:if>
            <xsl:value-of select="concat($position, '. ', .)"/>
            <xsl:if test="exists(../@href)">
                <xsl:text> </xsl:text>
                <a href="{../@href}" title="External Link">(Link)</a>
            </xsl:if>
        </h4>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    <xsl:template match="a">
        <a href="{@href}">
            <xsl:if test="exists(@title)">
                <xsl:attribute name="title" select="@title"/>
            </xsl:if>
            <xsl:apply-templates select="node()"/>
        </a>
    </xsl:template>
    <xsl:template match="ul">
        <ul>
            <xsl:apply-templates select="li"/>
        </ul>
    </xsl:template>
    <xsl:template match="li">
        <li id="{concat(../../@id, '-', @reqref)}">
            <b>
                <a href="#{@reqref}">
                    <xsl:value-of select="id(@reqref)/title"/>
                </a>
                <xsl:text>: </xsl:text>
            </b>
            <xsl:apply-templates select="node()"/>
        </li>
    </xsl:template>
</xsl:stylesheet>