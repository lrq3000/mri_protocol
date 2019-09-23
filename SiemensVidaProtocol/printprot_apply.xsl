<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>
  <!-- Define style -->
  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">
          body
          {
          font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
          font-size: 11px;
          }
          h3
          {
          text-align: center;
          font-size: 16px;
          }
          table
          {
          font-size: 11px; /* Safari */
          border-collapse: collapse;
          width: 100%;
          }
          tr.striped:nth-child(even)
          {
          background-color: #F2F2F2;
          }
          td
          {
          border: none;
          }
          td.center
          {
          text-align: center;
          }
          td.left
          {
          text-align: left;
          }
          td.right
          {
          text-align: right;
          }
          .tb-of-contents
          {
          text-align: left;
          }
          fieldset
          {
          border: 1px solid black;
          padding: 5px;
          -webkit-column-break-inside: avoid; /* Chrome, Safari, Opera */
          page-break-inside: avoid; /* Firefox */
          break-inside: avoid; /* IE 10+ */
          }
          fieldset.marginafter
          {
          margin-left: 0px;
          margin-right: 0px;
          margin-bottom: 10px;
          }
          legend
          {
          color: #00F;
          }
          .protocolheader
          {
          text-align: center;
          margin-top: 50px;
          background-color: #E5E5E5;
          }
          .protocol
          {
          -webkit-column-count: 8; /* Chrome, Safari, Opera */
          -moz-column-count: 8; /* Firefox */
          column-count: 8;
          -webkit-column-width: 200px;
          -moz-column-width: 200px;
          column-width: 200px;
          }
          ul
          {
          list-style-type: none;
          text-align: left;
          border-left: 1px solid #666;
          margin-left: 35px;
          margin-bottom: 10px;
          padding-left: 5px;
          }
          .ie9andlower /* do not understand multi-column layout so make it appear as before i.e. narrow single column */
          {
          width: 400px;
          max-width: 400px;
          margin: 0 auto;
          text-align: center;
          }
          *
          {
          -webkit-box-sizing: border-box;
          -moz-box-sizing: border-box;
          box-sizing: border-box;
          }
        </style>
      </head>
      <body>
        <xsl:comment>[if lte IE 9]>&lt;div class="ie9andlower">&lt;![endif]</xsl:comment>
        <xsl:apply-templates />
        <xsl:comment>[if lte IE 9]>&lt;/div>&lt;![endif]</xsl:comment>
      </body>
    </html>
  </xsl:template>

  <!-- Print Protocol -->
  <xsl:template match="PrintProtocol">
    <xsl:for-each select="Protocol">
      <xsl:for-each select="SubStep">
        <div class="protocolheader">
          <fieldset class="marginafter">
            <table>
              <tr class="center">
                <xsl:element name="td">
                  <xsl:attribute name="id">
                    <xsl:value-of select="../@Id"/>
                  </xsl:attribute>
                  <xsl:attribute name="class">center</xsl:attribute>
                  <xsl:value-of select="ProtHeaderInfo/HeaderProtPath"/>
                </xsl:element>
                <td>
                  <a href="#toc">top</a>
                </td>
              </tr>
              <tr>
                <td class="center">
                  <xsl:value-of select="ProtHeaderInfo/HeaderProperty"/>
                </td>
              </tr>
            </table>
          </fieldset>
        </div>
        <div class="protocol">
          <xsl:for-each select="Card">
            <fieldset class="marginafter">
              <legend>
                <xsl:value-of select="@name"/>
              </legend>
              <table>
                <xsl:for-each select="ProtParameter">
                  <tr class="striped">
                    <td class="left">
                      <xsl:value-of select="Label"/>
                    </td>
                    <td class="right">
                      <xsl:value-of select="ValueAndUnit"/>
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
            </fieldset>
          </xsl:for-each>
        </div>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- Table of contents -->
  <xsl:template match="PrintTOC">
    <xsl:for-each select="TOC">
      <h3 id="toc">
        <xsl:value-of select="HeaderTitle"/>
      </h3>
      <div class="tb-of-contents">
        <fieldset class="marginafter">
          <table>
            <tr>
              <td class="center">
                <xsl:value-of select="ProtHeaderInfo/HeaderProperty"/>
              </td>
            </tr>
          </table>
          <ul>
            <xsl:for-each select="root">
              <li>
                <xsl:value-of select="@name"/>
                <ul>
                  <xsl:for-each select="region">
                    <li>
                      <xsl:value-of select="@name"/>
                      <ul class="NormalExam_dot_engine">
                        <xsl:for-each select="NormalExam_dot_engine">
                          <li>
                            <xsl:value-of select="@name"/>
                            <ul class="program">
                              <xsl:for-each select="program">
                                <li>
                                  <xsl:value-of select="@name"/>
                                  <ul class="NormalStep_decision_branch">
                                    <xsl:for-each select="NormalStep_decision_branch">
                                      <li>
                                        <xsl:element name="a">
                                          <xsl:attribute name="href">
                                            <xsl:value-of select="concat('#', @Id)"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="@name"/>
                                        </xsl:element>
                                        <xsl:for-each select="strategy_branch">
                                          <xsl:for-each select="step_dot_engine">
                                            <xsl:value-of select="."/>
                                          </xsl:for-each>
                                        </xsl:for-each>
                                      </li>
                                    </xsl:for-each>
                                  </ul>
                                </li>
                              </xsl:for-each>
                            </ul>
                          </li>
                        </xsl:for-each>
                      </ul>
                    </li>
                  </xsl:for-each>
                </ul>
              </li>
            </xsl:for-each>
          </ul>
        </fieldset>
      </div>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
