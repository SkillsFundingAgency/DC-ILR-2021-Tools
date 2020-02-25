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
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_UKPRN)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">UKPRN</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_UKPRN)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <entity>
                            <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                            </xsl:attribute>
                            <xsl:attribute name="id">Learner</xsl:attribute>
                            <xsl:attribute name="complete">
                                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                            </xsl:attribute>
                            <xsl:for-each select="Learner">
                                <xsl:variable name="var_AcadMonthPayment"
                                              select="@AcadMonthPayment"/>
                                <xsl:variable name="var_FundLine"
                                              select="@FundLine"/>
                                <xsl:variable name="var_LearnerActEndDate"
                                              select="@LearnerActEndDate"/>
                                <xsl:variable name="var_LearnerPlanEndDate"
                                              select="@LearnerPlanEndDate"/>
                                <xsl:variable name="var_LearnerStartDate"
                                              select="@LearnerStartDate"/>
                                <xsl:variable name="var_LearnRefNumber"
                                              select="@LearnRefNumber"/>
                                <xsl:variable name="var_OnProgPayment"
                                              select="@OnProgPayment"/>
                                <instance>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="generate-id(.)"/>
                                    </xsl:attribute>
                                    <xsl:if test="string(boolean($var_AcadMonthPayment)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">AcadMonthPayment</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_AcadMonthPayment)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_FundLine)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">FundLine</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_FundLine)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LearnerActEndDate)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnerActEndDate</xsl:attribute>
                                            <date-val>
                                                <xsl:value-of select="string($var_LearnerActEndDate)"/>
                                            </date-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LearnerPlanEndDate)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnerPlanEndDate</xsl:attribute>
                                            <date-val>
                                                <xsl:value-of select="string($var_LearnerPlanEndDate)"/>
                                            </date-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LearnerStartDate)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnerStartDate</xsl:attribute>
                                            <date-val>
                                                <xsl:value-of select="string($var_LearnerStartDate)"/>
                                            </date-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LearnRefNumber)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnRefNumber</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_LearnRefNumber)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_OnProgPayment)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">OnProgPayment</xsl:attribute>
                                            <currency-val>
                                                <xsl:value-of select="string($var_OnProgPayment)"/>
                                            </currency-val>
                                        </attribute>
                                    </xsl:if>
                                </instance>
                            </xsl:for-each>
                        </entity>
                    </instance>
                </xsl:for-each>
            </entity>
        </session-data>
    </xsl:template>
</xsl:stylesheet>
