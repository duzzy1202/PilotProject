package com.ljh.footballaround.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.AttrDao;
import com.ljh.footballaround.dto.Attr;

@Service
public class AttrService {
	@Autowired
	private AttrDao attrDao;
	@Autowired
	private MailService mailService;
	
	public Attr get(String name) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		
		return attrDao.get(attr);
	}

	public int setValue(String name, String value) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		attr.put("value", value);

		return attrDao.setValue(attr);
	}

	public String getValue(String name) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		
		return attrDao.getValue(attr);
	}
	/* attr 삭제 
	public int remove(String name) {
		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];
		
		return attrDao.remove(relTypeCode, relId, typeCode, type2Code);
	}
	*/

	public void updateValue(String name, String value) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		attr.put("value", value);
		
		attrDao.updateValue(attr);
	}

	public Attr getAttr(String name) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		attr.put("value", nameBits[4]);
		
		return attrDao.getAttr(attr);
	}
	
	public List<Attr> getReportedArticlesByRelTypeCode(String relTypeCode) {
		return attrDao.getReportedArticlesByRelTypeCode(relTypeCode);
	}

	public void deleteAttr(int id) {
		attrDao.deleteAttr(id);
	}
	
	public List<String> getValueByTypeCodeAndType2Code(String name) {
		String[] nameBits = name.split("__");
		
		Map<String, Object> attr = new HashMap<>();
		attr.put("relTypeCode", nameBits[0]);
		attr.put("relId", Integer.parseInt(nameBits[1]));
		attr.put("typeCode", nameBits[2]);
		attr.put("type2Code", nameBits[3]);
		
		return attrDao.getValueByTypeCodeAndType2Code(attr);
	}
	
}
