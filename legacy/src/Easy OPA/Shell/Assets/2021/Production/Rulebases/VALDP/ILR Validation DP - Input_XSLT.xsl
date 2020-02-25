<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs">
    <xsl:output method="xml"
                encoding="UTF-8"
                indent="yes"/>
    <xsl:template match="/">
        <session-data>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation"
                           namespace="http://www.w3.org/2001/XMLSchema-instance">C:/PROGRA~2/Oracle/POLICY~1/bin/sessiondata.xsd</xsl:attribute>
            <entity>
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
                <xsl:attribute name="id">global</xsl:attribute>
                <xsl:attribute name="complete">
                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                </xsl:attribute>
                <xsl:for-each select="global">
                    <xsl:variable name="var_DesktopMode"
                                  select="@DesktopMode"/>
                    <xsl:variable name="var_FilePreparationDate"
                                  select="@FilePreparationDate"/>
                    <xsl:variable name="var_OrgVersion"
                                  select="@OrgVersion"/>
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <xsl:variable name="var_ULNVersion"
                                  select="@ULNVersion"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_DesktopMode)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">DesktopMode</xsl:attribute>
                                <boolean-val>
                                    <xsl:value-of select="string($var_DesktopMode)"/>
                                </boolean-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FilePreparationDate)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">FilePreparationDate</xsl:attribute>
                                <date-val>
                                    <xsl:value-of select="string($var_FilePreparationDate)"/>
                                </date-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_OrgVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">OrgVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_OrgVersion)"/>
                                </text-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_UKPRN)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">UKPRN</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_UKPRN)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_ULNVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">ULNVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_ULNVersion)"/>
                                </text-val>
                            </attribute>
                        </xsl:if>
                        <entity>
                            <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                            </xsl:attribute>
                            <xsl:attribute name="id">LearnerDestinationAndProgression</xsl:attribute>
                            <xsl:attribute name="complete">
                                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                            </xsl:attribute>
                            <xsl:for-each select="LearnerDestinationAndProgression">
                                <xsl:variable name="var_LearnRefNumber"
                                              select="@LearnRefNumber"/>
                                <xsl:variable name="var_ULN"
                                              select="@ULN"/>
                                <xsl:variable name="var_ULNLookup"
                                              select="@ULNLookup"/>
                                <instance>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="generate-id(.)"/>
                                    </xsl:attribute>
                                    <xsl:if test="string(boolean($var_LearnRefNumber)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnRefNumber</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_LearnRefNumber)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_ULN)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">ULN</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_ULN)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_ULNLookup)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">ULNLookup</xsl:attribute>
                                            <boolean-val>
                                                <xsl:value-of select="string($var_ULNLookup)"/>
                                            </boolean-val>
                                        </attribute>
                                    </xsl:if>
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">DPOutcome</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="DPOutcome">
                                            <xsl:variable name="var_OutCode"
                                                          select="@OutCode"/>
                                            <xsl:variable name="var_OutCollDate"
                                                          select="@OutCollDate"/>
                                            <xsl:variable name="var_OutEndDate"
                                                          select="@OutEndDate"/>
                                            <xsl:variable name="var_OutStartDate"
                                                          select="@OutStartDate"/>
                                            <xsl:variable name="var_OutType"
                                                          select="@OutType"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_OutCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_OutCode)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutCollDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutCollDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_OutCollDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutEndDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutEndDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_OutEndDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutStartDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutStartDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_OutStartDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_OutType)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                            </instance>
                                        </xsl:for-each>
                                    </entity>
                                </instance>
                            </xsl:for-each>
                        </entity>
                    </instance>
                </xsl:for-each>
            </entity>
        </session-data>
    </xsl:template>
</xsl:stylesheet>
