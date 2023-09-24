package org.ezen.gamesavvy.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.service.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/upload")
@Log4j
public class GsProfileImgController {
	
	@Autowired
	private ProfileService profileService;
	
	//첨부 파일 정보 ajax로 반환
	@PostMapping(value = "/imgUpload", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody	
	public ResponseEntity<MemberProfileDTO> uploadAjaxPost(MultipartFile uploadFile,Principal principal) {
		
		log.info("update ajax post.........");
		
		MemberProfileDTO attachDTO = new MemberProfileDTO();
		String uploadFolder = "C:/upload";
		
		String uploadFolderPath = getFolder(); //yyyy/mm/dd
		
		//전체 경로 폴더
		File uploadPath = new File(uploadFolder, uploadFolderPath );		
		
		//getFolder()는 날짜별 폴더를 반환하는 메서드(yyyy/mm/dd)로 uploadPath객체는 c:/upload/yyyy/mm/dd 폴더 객체
		
		if (uploadPath.exists() == false)  {
			uploadPath.mkdirs(); //그날중 맨처음 업로드시만 만듬
		}
		
		String uploadFileName = uploadFile.getOriginalFilename();
		uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
		
		attachDTO.setFileName(uploadFileName);
		attachDTO.setUserid(principal.getName());
		log.info("로그인 userid : " + principal.getName());
		log.info("only file name: " + uploadFileName);
		
        UUID uuid = UUID.randomUUID(); //중복되지 않은 값 UUID객체 생성
        uploadFileName = uuid.toString() + "_" + uploadFileName;
        File saveFile = new File(uploadPath, uploadFileName);
		
		try {
			log.info("-------------------------------------");
			log.info("Upload File Name: " + uploadFile.getOriginalFilename());
			log.info("Upload File Size: " + uploadFile.getSize());
			
	        uploadFile.transferTo(saveFile);
	        
	        attachDTO.setUuid(uuid.toString());
	        attachDTO.setUploadPath(uploadFolderPath);
	        
	        if (checkImageType(saveFile)) {
	            attachDTO.setFileType(true);
	            
	            File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
	            FileOutputStream thumbnail = new FileOutputStream(thumbnailFile);
	            
	            Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
	            thumbnail.close();
	        }
	        
	        // Service 계층의 uploadProfileImage 메서드 호출
            profileService.uploadProfileImage(attachDTO);
	    } catch (Exception e) {
	        log.error(e.getMessage());
	    }
	    
	    return new ResponseEntity<>(attachDTO, HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/displayimg", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) { //클라이언트에서 이미지 파일만 보냄
		
		log.info("fileName: " + fileName);
		
		File file = new File("c:/upload/" + fileName); //이미지 파일들
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders(); //Content-Type속성을 넣어주기위해 생성
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			//FileCopyUtils.copyToByteArray(file)은 파일 객체를 바이트 배열로 변환 반환
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping(value = "/deleteFileimage", produces = { MediaType.TEXT_PLAIN_VALUE + ";charset=UTF-8" })	
	@ResponseBody
	public ResponseEntity<String> deleteFile(String uuid,String type,String fileName) {
		
		log.info("deleteFile: " + uuid);
		
		File file = null;
		
		try {
			
			file = new File("c:/upload/" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete(); //지정된 파일 삭제(이미지는 섬네일파일,일반파일은 파일 삭제)
			
			if (type.equals("image")) {
				//원본파일 구하기
				String largeFileName = file.getAbsolutePath().replace("s_", ""); //s_를 삭제
				
				log.info("largeFileName: " + largeFileName);

				file = new File(largeFileName);

				file.delete();

			}
			
			profileService.deleteProfileImage(uuid);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //Date객체를 정해진 패턴 문자열로 변환시 사용하는 객체

		Date date = new Date();

		String str = sdf.format(date); //날짜 객체를 정해진 포맷의 문자열로 변환

		return str.replace("-", File.separator); //문자열중 -를 File.separator(파일 구분자)로 변경
	}
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			//file객체의 Path객체에 있는 contentType을 알아냄
			if( contentType == null) {
				return false;
			}
			
			return contentType.startsWith("image");
			//startWith(문자열)은 문자열로 시작하면 true
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
}
