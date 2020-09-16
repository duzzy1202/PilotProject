package com.ljh.footballaround.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ljh.footballaround.dto.Attr;

@Mapper
public interface AttrDao {

	int setValue(Map<String, Object> attr);

	String getValue(Map<String, Object> attr);

	Attr get(Map<String, Object> attr);

	void updateValue(Map<String, Object> attr);

	Attr getAttr(Map<String, Object> attr);

	List<Attr> getReportedArticlesByRelTypeCode(String relTypeCode);

	void deleteAttr(int id);

	void updateRelTypeCode(int relId, String relTypeCode, String typeCode, String type2Code);

	List<String> getValueByTypeCodeAndType2Code(Map<String, Object> attr);

	
}
