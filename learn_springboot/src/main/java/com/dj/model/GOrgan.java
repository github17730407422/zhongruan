package com.dj.model;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * @author Administrator
 *
 */
@SuppressWarnings("unchecked")
public class GOrgan implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;

	private Log log = LogFactory.getLog(GOrgan.class);

	// Fields

	private String uuid;
	private String organCode;
	private String shortOrganCode;
	private String parentCode;
	private String otherParentCode;
	private String organName;
	private Integer organType;
	private String areaCode;
	private Integer orderNum;
	private Integer validFlag;
	private Integer delFlag;
	private String address;
	private String fax;
	private String zip;
	private String phone;
	private String website;
	private Integer serverId;
	private String picUrl;
	private Date lastDfReport;

	private String organTypeName;
	private String delFlagName;
	private String validFlagName;

	private String logoUrl;

	private Integer skinType;
	private String skinId;
	private String cssStyle;
	
	//党组织联系人
	private String dzzlxr;
	//党组织书记
	private String dzzsj;
	//组织类别
	private String organTypeStr;
	//党组织隶属关系
	private String belongTo;
	//党组织所在单位情况
	private String dzzszdwqk;
	//所属区域工委
	private String ssqygw;
	//地理位置坐标
	private String position;
	
	//部门名（以逗号隔开）
	private String depNames;
	
	//部门成立时间
	private Date foundDate;
	//党组织副书记
	private String dzzfsj;
	//挂靠城市及单位
	private String affiliated;
	//挂靠办理中  1:办理中 
	private Integer isDispose;
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Log getLog() {
		return log;
	}
	public String getUuid() {
		return uuid;
	}
	public String getOrganCode() {
		return organCode;
	}
	public String getShortOrganCode() {
		return shortOrganCode;
	}
	public String getParentCode() {
		return parentCode;
	}
	public String getOtherParentCode() {
		return otherParentCode;
	}
	public String getOrganName() {
		return organName;
	}
	public Integer getOrganType() {
		return organType;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public Integer getOrderNum() {
		return orderNum;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public Integer getDelFlag() {
		return delFlag;
	}
	public String getAddress() {
		return address;
	}
	public String getFax() {
		return fax;
	}
	public String getZip() {
		return zip;
	}
	public String getPhone() {
		return phone;
	}
	public String getWebsite() {
		return website;
	}
	public Integer getServerId() {
		return serverId;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public Date getLastDfReport() {
		return lastDfReport;
	}
	public String getOrganTypeName() {
		return organTypeName;
	}
	public String getDelFlagName() {
		return delFlagName;
	}
	public String getValidFlagName() {
		return validFlagName;
	}
	public String getLogoUrl() {
		return logoUrl;
	}
	public Integer getSkinType() {
		return skinType;
	}
	public String getSkinId() {
		return skinId;
	}
	public String getCssStyle() {
		return cssStyle;
	}
	public String getDzzlxr() {
		return dzzlxr;
	}
	public String getDzzsj() {
		return dzzsj;
	}
	public String getOrganTypeStr() {
		return organTypeStr;
	}
	public String getBelongTo() {
		return belongTo;
	}
	public String getDzzszdwqk() {
		return dzzszdwqk;
	}
	public String getSsqygw() {
		return ssqygw;
	}
	public String getPosition() {
		return position;
	}
	public String getDepNames() {
		return depNames;
	}
	public Date getFoundDate() {
		return foundDate;
	}
	public String getDzzfsj() {
		return dzzfsj;
	}
	public String getAffiliated() {
		return affiliated;
	}
	public Integer getIsDispose() {
		return isDispose;
	}
	public void setLog(Log log) {
		this.log = log;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	public void setShortOrganCode(String shortOrganCode) {
		this.shortOrganCode = shortOrganCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public void setOtherParentCode(String otherParentCode) {
		this.otherParentCode = otherParentCode;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public void setOrganType(Integer organType) {
		this.organType = organType;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
	}
	public void setDelFlag(Integer delFlag) {
		this.delFlag = delFlag;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public void setServerId(Integer serverId) {
		this.serverId = serverId;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public void setLastDfReport(Date lastDfReport) {
		this.lastDfReport = lastDfReport;
	}
	public void setOrganTypeName(String organTypeName) {
		this.organTypeName = organTypeName;
	}
	public void setDelFlagName(String delFlagName) {
		this.delFlagName = delFlagName;
	}
	public void setValidFlagName(String validFlagName) {
		this.validFlagName = validFlagName;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
	public void setSkinType(Integer skinType) {
		this.skinType = skinType;
	}
	public void setSkinId(String skinId) {
		this.skinId = skinId;
	}
	public void setCssStyle(String cssStyle) {
		this.cssStyle = cssStyle;
	}
	public void setDzzlxr(String dzzlxr) {
		this.dzzlxr = dzzlxr;
	}
	public void setDzzsj(String dzzsj) {
		this.dzzsj = dzzsj;
	}
	public void setOrganTypeStr(String organTypeStr) {
		this.organTypeStr = organTypeStr;
	}
	public void setBelongTo(String belongTo) {
		this.belongTo = belongTo;
	}
	public void setDzzszdwqk(String dzzszdwqk) {
		this.dzzszdwqk = dzzszdwqk;
	}
	public void setSsqygw(String ssqygw) {
		this.ssqygw = ssqygw;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public void setDepNames(String depNames) {
		this.depNames = depNames;
	}
	public void setFoundDate(Date foundDate) {
		this.foundDate = foundDate;
	}
	public void setDzzfsj(String dzzfsj) {
		this.dzzfsj = dzzfsj;
	}
	public void setAffiliated(String affiliated) {
		this.affiliated = affiliated;
	}
	public void setIsDispose(Integer isDispose) {
		this.isDispose = isDispose;
	}
	
	
}